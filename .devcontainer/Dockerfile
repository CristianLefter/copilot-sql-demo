# Use Ubuntu as base image
FROM ubuntu:20.04

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=P@$$w.rd123
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&     apt-get install -y curl apt-transport-https software-properties-common gnupg &&     curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - &&     curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list > /etc/apt/sources.list.d/mssql-server.list &&     apt-get update &&     apt-get install -y mssql-server mssql-tools unixodbc-dev &&     /opt/mssql/bin/mssql-conf -n setup accept-eula &&     /opt/mssql/bin/sqlservr & sleep 30 &&     /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Your_password123 -Q "SELECT @@VERSION"

EXPOSE 1433

CMD ["/opt/mssql/bin/sqlservr"]
