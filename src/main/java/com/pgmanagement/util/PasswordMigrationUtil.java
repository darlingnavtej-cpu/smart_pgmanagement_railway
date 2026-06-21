package com.pgmanagement.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PasswordMigrationUtil {

    public static void main(String[] args) {
        System.out.println("Starting database password migration...");
        List<String> schemas = new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 1. Get all SaaS tenant databases from the master routing table
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_pg_master", "root", "admin");
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT db_name FROM tenant_routing")) {
                while (rs.next()) {
                    schemas.add(rs.getString("db_name"));
                }
            }
            
            // Fallback: always migrate default admin DB
            if (!schemas.contains("smart_pg")) {
                schemas.add("smart_pg");
            }
            
            // 2. Loop through all schemas and migrate passwords
            for (String schema : schemas) {
                System.out.println("\nProcessing database schema: " + schema);
                
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + schema, "root", "admin")) {
                    
                    // A. Migrate admin passwords (newreg table)
                    try (Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT username, password FROM newreg")) {
                        List<String[]> adminUpdates = new ArrayList<>();
                        while (rs.next()) {
                            String username = rs.getString("username");
                            String pwd = rs.getString("password");
                            // If it's not a 64-char hex SHA-256 hash, mark for hashing
                            if (pwd != null && pwd.length() != 64) {
                                adminUpdates.add(new String[]{username, pwd});
                            }
                        }
                        
                        if (!adminUpdates.isEmpty()) {
                            // Expand column size first to be absolutely sure
                            try (Statement alterStmt = conn.createStatement()) {
                                alterStmt.executeUpdate("ALTER TABLE newreg MODIFY COLUMN password VARCHAR(100) NOT NULL");
                            }
                            
                            try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE newreg SET password=? WHERE username=?")) {
                                for (String[] admin : adminUpdates) {
                                    String hash = HashUtil.hashPassword(admin[1]);
                                    updateStmt.setString(1, hash);
                                    updateStmt.setString(2, admin[0]);
                                    updateStmt.executeUpdate();
                                    System.out.println("  - Hashed admin password for: " + admin[0]);
                                }
                            }
                        } else {
                            System.out.println("  - All admin passwords already hashed.");
                        }
                    } catch (Exception ex) {
                        System.err.println("  - Skipping admin migration (table might not exist in master schema): " + ex.getMessage());
                    }
                    
                    // B. Migrate tenant passwords (tenant table)
                    try (Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT tenant_id, password FROM tenant")) {
                        List<String[]> tenantUpdates = new ArrayList<>();
                        while (rs.next()) {
                            String tenantId = rs.getString("tenant_id");
                            String pwd = rs.getString("password");
                            // If it's not a 64-char hex SHA-256 hash, mark for hashing
                            if (pwd != null && pwd.length() != 64) {
                                tenantUpdates.add(new String[]{tenantId, pwd});
                            }
                        }
                        
                        if (!tenantUpdates.isEmpty()) {
                            // Expand column size first to be absolutely sure
                            try (Statement alterStmt = conn.createStatement()) {
                                alterStmt.executeUpdate("ALTER TABLE tenant MODIFY COLUMN password VARCHAR(100) NOT NULL");
                            }
                            
                            try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE tenant SET password=? WHERE tenant_id=?")) {
                                for (String[] tenant : tenantUpdates) {
                                    String hash = HashUtil.hashPassword(tenant[1]);
                                    updateStmt.setString(1, hash);
                                    updateStmt.setString(2, tenant[0]);
                                    updateStmt.executeUpdate();
                                    System.out.println("  - Hashed tenant password for ID: " + tenant[0]);
                                }
                            }
                        } else {
                            System.out.println("  - All tenant passwords already hashed.");
                        }
                    } catch (Exception ex) {
                        System.err.println("  - Skipping tenant migration: " + ex.getMessage());
                    }
                } catch (Exception ex) {
                    System.err.println("  - Error connecting to schema " + schema + ": " + ex.getMessage());
                }
            }
            
            System.out.println("\nDatabase password migration completed successfully!");
            
        } catch (Exception e) {
            System.err.println("Migration failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
