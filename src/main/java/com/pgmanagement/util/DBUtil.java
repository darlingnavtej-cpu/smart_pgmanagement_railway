package com.pgmanagement.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    
    private static final ThreadLocal<String> currentDb = new ThreadLocal<>();

    public static void setCurrentDb(String dbName) {
        currentDb.set(dbName);
    }

    public static String getCurrentDb() {
        return currentDb.get();
    }

    public static void clear() {
        currentDb.remove();
    }

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        String dbName = currentDb.get();
        if (dbName == null) {
            dbName = "smart_pg"; // Fallback to default schema
        }
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, "root", "admin");
    }

    public static Connection getMasterConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_pg_master", "root", "admin");
    }
}
