#!/bin/bash

echo "Waiting for SQL Server to start..."
sleep 20

RETRIES=20
until /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P P@ssw0rd123 -Q "SELECT 1" > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "❌ SQL Server not ready yet... waiting"
  sleep 5
  ((RETRIES--))
done

if [ $RETRIES -eq 0 ]; then
  echo "SQL Server failed to start within expected time. Exiting setup."
  exit 1
fi


echo "Running schema.sql..."
sqlcmd -S localhost -U SA -P P@ssw0rd123 -d master -i /workspace/sql/schema.sql



