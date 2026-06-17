#!/bin/bash
# Startup script for SmartPGManagementSystem
# Configures remote Railway MySQL database, runs migrations, and starts supervisord

echo "Checking database connection parameters..."
if [ -z "$MYSQLHOST" ] || [ -z "$MYSQLPORT" ] || [ -z "$MYSQLUSER" ] || [ -z "$MYSQLPASSWORD" ]; then
  echo "ERROR: Railway MySQL environment variables (MYSQLHOST, MYSQLPORT, MYSQLUSER, MYSQLPASSWORD) are not defined!"
  echo "Please link the MySQL service to the app service or define these variables."
  exit 1
fi

echo "Connecting to Railway MySQL at $MYSQLHOST:$MYSQLPORT..."

# Wait for MySQL to be reachable
for i in {1..30}; do
  if mysqladmin ping -h "$MYSQLHOST" -P "$MYSQLPORT" --silent; then
    echo "MySQL is reachable!"
    break
  fi
  echo "Waiting for MySQL to become reachable... ($i/30)"
  sleep 2
done

# Check if we can already login with password 'admin'
if mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u root -padmin -e "SELECT 1;" >/dev/null 2>&1; then
  echo "Connection verified! Root password is already 'admin'."
else
  echo "Could not connect with 'admin'. Attempting to set root password to 'admin' using Railway credentials..."
  # Connect using Railway default credentials and set root password to 'admin'
  # (Crucial because Java code is hardcoded to use password 'admin')
  mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "
    ALTER USER 'root'@'%' IDENTIFIED BY 'admin';
    FLUSH PRIVILEGES;
  "
  if [ $? -eq 0 ]; then
    echo "Root password successfully updated to 'admin'!"
  else
    echo "ERROR: Failed to update root password to 'admin' using Railway credentials."
    exit 1
  fi
fi

# Run database migrations/initialization if not done
if ! mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u root -padmin -e "USE smart_pg;" >/dev/null 2>&1; then
  echo "Database smart_pg not found. Initializing schema..."
  if [ -f "/opt/init.sql" ]; then
    mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u root -padmin < /opt/init.sql
    echo "Database schema and views successfully initialized!"
  else
    echo "ERROR: init.sql not found at /opt/init.sql!"
    exit 1
  fi
else
  echo "Database smart_pg already initialized. Checking compatibility views..."
  # Ensure the compatibility views exist even if the DB was already created
  mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u root -padmin -e "
    CREATE DATABASE IF NOT EXISTS pg_info_table;
    CREATE OR REPLACE VIEW pg_info_table.pg_info AS SELECT * FROM smart_pg.pg_info;
    CREATE DATABASE IF NOT EXISTS tenant_table;
    CREATE OR REPLACE VIEW tenant_table.tenant AS SELECT * FROM smart_pg.tenant;
  "
  echo "Compatibility views verified."
fi

# Configure Tomcat to listen on the dynamic port assigned by Railway
if [ -n "$PORT" ]; then
  echo "Configuring Tomcat to listen on port $PORT"
  sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /opt/tomcat/conf/server.xml
else
  echo "PORT is empty. Tomcat will use default 8080."
fi

# Start supervisord (which runs socat to forward localhost:3306 -> Railway MySQL, and tomcat)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

