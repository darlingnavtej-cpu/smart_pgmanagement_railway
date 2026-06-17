#!/bin/bash
# Startup script for SmartPGManagementSystem
# Starts MySQL first, waits for it, then launches supervisord

# Ensure proper directories exist and have right ownership
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld

# Initialize MySQL data directory if a blank persistent volume is mounted
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "MySQL data directory is empty. Initializing database..."
  mysqld --initialize-insecure --user=mysql
  
  # Start MySQL in background to import database
  /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
  PID=$!
  
  echo "Waiting for MySQL to start..."
  for i in {1..30}; do
    mysqladmin ping -h localhost --silent && break
    sleep 1
  done
  
  # Configure root privileges & load schema
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin'; FLUSH PRIVILEGES;"
  mysql -u root -padmin -e "CREATE DATABASE IF NOT EXISTS smart_pg;"
  if [ -f "/opt/init.sql" ]; then
    mysql -u root -padmin smart_pg < /opt/init.sql
  fi
  
  # Clean shutdown of temporary MySQL instance
  mysqladmin -u root -padmin shutdown
  wait $PID
  echo "Database initialization complete!"
fi

# Configure Tomcat to listen on the dynamic port assigned by Railway
if [ -n "$PORT" ]; then
  echo "Configuring Tomcat to listen on port $PORT"
  sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /opt/tomcat/conf/server.xml
fi

# Start supervisord (which manages both MySQL and Tomcat)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
