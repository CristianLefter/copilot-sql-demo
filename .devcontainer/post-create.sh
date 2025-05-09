#!/bin/bash

echo "🔍 Checking if SQL Server (mssql) container is running..."

if ! docker ps | grep -q "mssql"; then
  echo "❌ SQL Server container is not running!"
  docker ps -a
  echo "💥 Container logs:"
  docker logs $(docker ps -a -q --filter "name=mssql")
  exit 1
fi

echo "⏳ Waiting for SQL Server sidecar (mssql) to be ready..."

RETRIES=30
until sqlcmd -S mssql -U SA -P P@ssw0rd123 -Q "SELECT 1" > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "❌ Still waiting for SQL Server..."
  sleep 5
  ((RETRIES--))
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ SQL Server sidecar failed to become ready after retries."
  docker logs $(docker ps -a -q --filter "name=mssql")
  exit 1
fi

echo "✅ SQL Server is up. Running schema..."
sqlcmd -S mssql -U SA -P P@ssw0rd123 -d master -i /workspace/sql/schema.sql
