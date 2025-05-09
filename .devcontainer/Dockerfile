FROM mcr.microsoft.com/devcontainers/dotnet:0-ubuntu-22.04

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=P@ssw0rd123
ENV DEBIAN_FRONTEND=noninteractive

# Install SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - &&     curl https://packages.microsoft.com/config/ubuntu/22.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server.list &&     curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/msprod.list &&     apt-get update &&     ACCEPT_EULA=Y apt-get install -y mssql-server mssql-tools unixodbc-dev &&     echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /etc/bash.bashrc &&     ln -s /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd &&     ln -s /opt/mssql-tools/bin/bcp /usr/bin/bcp &&     apt-get clean

# Run SQL Server on container start
CMD ["/opt/mssql/bin/sqlservr"]
