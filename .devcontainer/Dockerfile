FROM ubuntu:20.04

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=P@ssw0rd123
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&     apt-get install -y curl gnupg2 software-properties-common apt-transport-https wget sudo &&     curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - &&     curl https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2019.list | tee /etc/apt/sources.list.d/mssql-server.list &&     curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list &&     apt-get update &&     ACCEPT_EULA=Y apt-get install -y mssql-server mssql-tools unixodbc-dev &&     echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc &&     ln -s /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd &&     ln -s /opt/mssql-tools/bin/bcp /usr/bin/bcp &&     apt-get clean &&     useradd -m vscode &&     mkdir -p /etc/sudoers.d &&     echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode &&     chmod 0440 /etc/sudoers.d/vscode

USER vscode
WORKDIR /workspaces

EXPOSE 1433
CMD ["/opt/mssql/bin/sqlservr"]
