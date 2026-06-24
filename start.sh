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

# Verify connection using Railway credentials
if mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "SELECT 1;" >/dev/null 2>&1; then
  echo "Connection verified using Railway database credentials."
else
  echo "ERROR: Could not connect to Railway MySQL using the provided credentials!"
  exit 1
fi

# Run database migrations/initialization if not done
if ! mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "USE smart_pg;" >/dev/null 2>&1; then
  echo "Database smart_pg not found. Initializing schema..."
  if [ -f "/opt/init.sql" ]; then
    mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" < /opt/init.sql
    echo "Database schema and views successfully initialized!"
  else
    echo "ERROR: init.sql not found at /opt/init.sql!"
    exit 1
  fi
else
  echo "Database smart_pg already initialized. Checking compatibility views and master schema..."
  if [ -f "/opt/init.sql" ]; then
    mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" < /opt/init.sql
  fi
  # Ensure the compatibility views exist even if the DB was already created
  mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "
    CREATE DATABASE IF NOT EXISTS pg_info_table;
    CREATE OR REPLACE VIEW pg_info_table.pg_info AS SELECT * FROM smart_pg.pg_info;
    CREATE DATABASE IF NOT EXISTS tenant_table;
    CREATE OR REPLACE VIEW tenant_table.tenant AS SELECT * FROM smart_pg.tenant;
  "
  echo "Compatibility views and master schema verified."
fi

# Initialize smart_pg_royal and smart_pg_palms test databases if they don't exist
for test_db in smart_pg_royal smart_pg_palms; do
  if ! mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "USE $test_db;" >/dev/null 2>&1; then
    echo "Creating and initializing test database $test_db..."
    mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD" -e "CREATE DATABASE IF NOT EXISTS $test_db;"
    # Run schema replacing USE `smart_pg` with USE `test_db`
    sed "s/USE \`smart_pg\`/USE \`$test_db\`/g" /opt/init.sql | mysql -h "$MYSQLHOST" -P "$MYSQLPORT" -u "$MYSQLUSER" -p"$MYSQLPASSWORD"
    echo "Test database $test_db successfully initialized!"
  fi
done


# Configure Tomcat to listen on the dynamic port assigned by Railway
if [ -n "$PORT" ]; then
  echo "Configuring Tomcat to listen on port $PORT"
  sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /opt/tomcat/conf/server.xml
else
  echo "PORT is empty. Tomcat will use default 8080."
fi

# Start supervisord (which runs socat to forward localhost:3306 -> Railway MySQL, and tomcat)
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

