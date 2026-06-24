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
        return getConnection(dbName);
    }

    public static Connection getConnection(String dbName) throws SQLException, ClassNotFoundException {
        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String user = System.getenv("MYSQLUSER");
        String password = System.getenv("MYSQLPASSWORD");
        
        if (host == null || host.trim().isEmpty()) {
            host = "localhost";
            port = "3306";
            user = "root";
            password = "admin"; // Default local fallback
        }
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true";
        return DriverManager.getConnection(url, user, password);
    }

    public static Connection getMasterConnection() throws SQLException, ClassNotFoundException {
        return getConnection("smart_pg_master");
    }
}
