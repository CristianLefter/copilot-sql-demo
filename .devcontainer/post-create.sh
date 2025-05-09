#!/bin/bash

echo "⏳ Waiting for SQL Server service container (mssql) to be ready..."

RETRIES=30
until sqlcmd -S mssql -U SA -P P@ssw0rd123 -Q "SELECT 1" > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "❌ SQL Server sidecar not ready yet... waiting"
  sleep 5
  ((RETRIES--))
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ SQL Server service container failed to start. Exiting setup."
  exit 1
fi

echo "✅ SQL Server is ready. Running schema.sql..."
sqlcmd -S mssql -U SA -P P@ssw0rd123 -d master -i /workspace/sql/schema.sql
