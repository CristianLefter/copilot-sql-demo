# [Choice] .NET version: 6.0-focal, 3.1-focal
ARG VARIANT="6.0-focal"
FROM mcr.microsoft.com/devcontainers/dotnet:0-${VARIANT}

# Add .NET global tools path
ENV PATH $PATH:/home/vscode/.dotnet:/home/vscode/.dotnet/tools

# [Choice] Node.js version: none, lts/*, 18, 16, 14
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Install SQL Tools: SQLPackage and sqlcmd
COPY mssql/installSQLtools.sh installSQLtools.sh
RUN bash ./installSQLtools.sh \
     && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts
