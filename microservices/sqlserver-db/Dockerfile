# Use the official SQL Server 2022 image from Microsoft
# https://hub.docker.com/r/microsoft/mssql-server
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set the environment variables for SQL Server
ENV ACCEPT_EULA=Y
# ENV SA_PASSWORD=Strong@Passw0rd
# ENV MSSQL_PID=Developer
# ENV MSSQL_TCP_PORT=1433

# Create a directory inside the container to copy your SQL scripts
WORKDIR /src

# Copy your SQL scripts into the container [optional]
COPY scripts.sql ./scripts.sql

# Set permissions for the SQL scripts
# RUN chmod +x ./scripts.sql

# RUN SQL SERVER and Access SQL CLI on localhost with given credentials
# Then run SQL Script - scripts.sql
# RUN /opt/mssql/bin/sqlservr
# RUN /opt/mssql-tools18/bin/sqlcmd -S127.0.0.1 -C -Usa -P${SA_PASSWORD} -i scripts.sql