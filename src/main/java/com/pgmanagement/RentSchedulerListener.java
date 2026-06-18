package com.pgmanagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Locale;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class RentSchedulerListener implements ServletContextListener {

	private ScheduledExecutorService scheduler;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("RentSchedulerListener: Initializing monthly rent background scheduler...");
		scheduler = Executors.newSingleThreadScheduledExecutor();
		// Run immediately, and then check every 12 hours
		scheduler.scheduleAtFixedRate(new RentGeneratorTask(), 0, 12, TimeUnit.HOURS);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("RentSchedulerListener: Stopping monthly rent background scheduler...");
		if (scheduler != null) {
			scheduler.shutdown();
			try {
				if (!scheduler.awaitTermination(5, TimeUnit.SECONDS)) {
					scheduler.shutdownNow();
				}
			} catch (InterruptedException e) {
				scheduler.shutdownNow();
			}
		}
	}

	private static class RentGeneratorTask implements Runnable {
		@Override
		public void run() {
			System.out.println("RentGeneratorTask: Starting check for missing monthly rent records across all tenants...");
			
			Connection masterCon = null;
			PreparedStatement getTenantsSchemasStmt = null;
			ResultSet schemasRs = null;

			try {
				// 1. Fetch all active tenant schemas from the master routing database
				masterCon = com.pgmanagement.util.DBUtil.getMasterConnection();
				getTenantsSchemasStmt = masterCon.prepareStatement("SELECT db_name FROM tenant_routing WHERE status = 'active'");
				schemasRs = getTenantsSchemasStmt.executeQuery();

				while (schemasRs.next()) {
					String dbSchema = schemasRs.getString("db_name");
					System.out.println("RentGeneratorTask: Processing rent for database schema: " + dbSchema);
					try {
						// Set the thread local database context
						com.pgmanagement.util.DBUtil.setCurrentDb(dbSchema);
						processTenantRent(dbSchema);
					} catch (Exception e) {
						System.err.println("RentGeneratorTask Error processing " + dbSchema + ": " + e.getMessage());
						e.printStackTrace();
					} finally {
						// Always clean up thread local
						com.pgmanagement.util.DBUtil.clear();
					}
				}
			} catch (Exception e) {
				System.err.println("RentGeneratorTask Master Query Error: " + e.getMessage());
				e.printStackTrace();
			} finally {
				try {
					if (schemasRs != null) schemasRs.close();
					if (getTenantsSchemasStmt != null) getTenantsSchemasStmt.close();
					if (masterCon != null) masterCon.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		private void processTenantRent(String dbSchema) {
			Connection con = null;
			PreparedStatement getTenantsStmt = null;
			PreparedStatement checkFeeStmt = null;
			PreparedStatement getRentStmt = null;
			PreparedStatement insertFeeStmt = null;
			PreparedStatement logActivityStmt = null;
			ResultSet tenantsRs = null;
			ResultSet checkFeeRs = null;
			ResultSet rentRs = null;

			try {
				// Get current month name formatted as Titlecase (e.g. "July")
				String monthName = java.time.LocalDate.now().getMonth().getDisplayName(java.time.format.TextStyle.FULL, Locale.ENGLISH);

				con = com.pgmanagement.util.DBUtil.getConnection();

				// Get all tenants
				getTenantsStmt = con.prepareStatement("SELECT tenant_id, tenant_name, room_no FROM tenant");
				tenantsRs = getTenantsStmt.executeQuery();

				int generatedCount = 0;

				while (tenantsRs.next()) {
					String tenantIdStr = tenantsRs.getString("tenant_id");
					String tenantName = tenantsRs.getString("tenant_name");
					int roomNo = tenantsRs.getInt("room_no");

					// Convert tenantIdStr to integer safely
					int tenantId = 0;
					try {
						tenantId = Integer.parseInt(tenantIdStr);
					} catch (NumberFormatException e) {
						System.err.println("RentGeneratorTask[" + dbSchema + "]: Invalid tenant_id format: " + tenantIdStr);
						continue;
					}

					// Check if fee record exists for this tenant and current month
					checkFeeStmt = con
							.prepareStatement("SELECT COUNT(*) FROM fee WHERE tenant_id = ? AND month_name = ?");
					checkFeeStmt.setInt(1, tenantId);
					checkFeeStmt.setString(2, monthName);
					checkFeeRs = checkFeeStmt.executeQuery();

					boolean feeExists = false;
					if (checkFeeRs.next()) {
						feeExists = checkFeeRs.getInt(1) > 0;
					}
					checkFeeRs.close();
					checkFeeStmt.close();

					if (!feeExists) {
						// Retrieve the room rent from room table
						getRentStmt = con.prepareStatement("SELECT rent FROM room WHERE room_no = ?");
						getRentStmt.setInt(1, roomNo);
						rentRs = getRentStmt.executeQuery();
						double rentAmount = 10000; // Default rent fallback
						if (rentRs.next()) {
							rentAmount = rentRs.getDouble("rent");
						}
						rentRs.close();
						getRentStmt.close();

						// Insert new fee record as "Pending"
						insertFeeStmt = con.prepareStatement(
								"INSERT INTO fee (tenant_id, month_name, amount, paid_date, status) VALUES (?, ?, ?, ?, 'Pending')");
						insertFeeStmt.setInt(1, tenantId);
						insertFeeStmt.setString(2, monthName);
						insertFeeStmt.setDouble(3, rentAmount);
						insertFeeStmt.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
						insertFeeStmt.executeUpdate();
						insertFeeStmt.close();

						System.out.println("RentGeneratorTask[" + dbSchema + "]: Auto-generated Pending rent of ₹" + rentAmount + " for "
								+ tenantName + " (ID: " + tenantId + ") for " + monthName);
						generatedCount++;
					}
				}

				if (generatedCount > 0) {
					// Log system activity
					logActivityStmt = con.prepareStatement(
							"INSERT INTO activity (activity_text, activity_time) VALUES (?, NOW())");
					logActivityStmt.setString(1, "🗓️ Auto-generated pending rent records for " + generatedCount
							+ " tenants for " + monthName);
					logActivityStmt.executeUpdate();
					logActivityStmt.close();
				}

			} catch (Exception e) {
				System.err.println("RentGeneratorTask[" + dbSchema + "] Error: " + e.getMessage());
				e.printStackTrace();
			} finally {
				try {
					if (tenantsRs != null) tenantsRs.close();
					if (getTenantsStmt != null) getTenantsStmt.close();
					if (con != null) con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}

