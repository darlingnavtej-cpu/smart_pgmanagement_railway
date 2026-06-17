#!/bin/bash
# Startup script for SmartPGManagementSystem
# Starts MySQL first, waits for it, then launches supervisord

# Fix MySQL data directory permissions
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld 2>/dev/null || mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld

# Configure Tomcat to listen on the dynamic port assigned by Railway
if [ -n "$PORT" ]; then
  echo "Configuring Tomcat to listen on port $PORT"
  sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /opt/tomcat/conf/server.xml
fi

# Start supervisord (which manages both MySQL and Tomcat)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
