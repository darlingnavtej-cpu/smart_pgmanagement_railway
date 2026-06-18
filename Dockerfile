# ===========================================
# SmartPGManagementSystem - Railway Deployment
# Bundles: Maven Build + Tomcat 9 + MySQL 8
# ===========================================

# ---- Stage 1: Build the WAR with Maven ----
FROM maven:3.9-eclipse-temurin-8 AS builder

WORKDIR /app
COPY pom.xml .
RUN mvn dependency:resolve -q

COPY src ./src
RUN mvn clean package -q -DskipTests

# ---- Stage 2: Runtime (Tomcat + Remote MySQL Proxy) ----
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install OpenJDK 8, MySQL Client, Supervisor, curl, socat
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-8-jre-headless \
        mysql-client \
        supervisor \
        curl \
        sed \
        socat \
        && rm -rf /var/lib/apt/lists/*

# Copy init SQL
COPY init.sql /opt/init.sql

# Create socat startup script
RUN echo '#!/bin/bash\n\
if [ -z "$MYSQLHOST" ] || [ -z "$MYSQLPORT" ]; then\n\
  echo "MYSQLHOST or MYSQLPORT env vars are missing. socat cannot start."\n\
  exit 1\n\
fi\n\
echo "Starting socat proxy: localhost:3306 -> $MYSQLHOST:$MYSQLPORT"\n\
exec socat TCP-LISTEN:3306,fork,reuseaddr TCP:$MYSQLHOST:$MYSQLPORT\n\
' > /usr/local/bin/start_socat.sh && chmod +x /usr/local/bin/start_socat.sh


# ---- Install Tomcat 9 ----
ENV CATALINA_HOME=/opt/tomcat
ENV TOMCAT_VERSION=9.0.118

RUN mkdir -p ${CATALINA_HOME} && \
    (curl -fsSL "https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
     || curl -fsSL "https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz") \
    | tar xz --strip-components=1 -C ${CATALINA_HOME} && \
    rm -rf ${CATALINA_HOME}/webapps/ROOT \
           ${CATALINA_HOME}/webapps/docs \
           ${CATALINA_HOME}/webapps/examples \
           ${CATALINA_HOME}/webapps/host-manager \
           ${CATALINA_HOME}/webapps/manager

# Copy the built WAR as ROOT.war (app at /)
COPY --from=builder /app/target/SmartPGManagementSystem.war ${CATALINA_HOME}/webapps/ROOT.war

# ---- Supervisor + Startup ----
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway uses PORT env var
EXPOSE 8080

CMD ["/start.sh"]
