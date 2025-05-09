#!/bin/bash

echo "⏳ Waiting for SQL Server sidecar (mssql) to respond..."

RETRIES=30
until sqlcmd -S mssql -U SA -P P@ssw0rd123 -Q "SELECT 1" > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "❌ SQL Server not ready yet... retrying ($RETRIES left)"
  sleep 5
  ((RETRIES--))
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ SQL Server did not respond after retries. Please run this manually to debug:"
  echo "sqlcmd -S mssql -U SA -P P@ssw0rd123 -Q \"SELECT @@VERSION\""
  exit 1
fi

echo "✅ SQL Server is ready. Running schema..."
sqlcmd -S mssql -U SA -P P@ssw0rd123 -d master -i /workspace/sql/schema.sql
