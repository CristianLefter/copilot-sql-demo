#!/bin/bash

echo "🔍 Checking if the SQL Server sidecar (mssql) container is running..."

MSSQL_CONTAINER_ID=$(docker ps -aqf "name=mssql")

if [ -z "$MSSQL_CONTAINER_ID" ]; then
  echo "❌ No container with name 'mssql' found. Printing all containers:"
  docker ps -a
  exit 1
fi

RUNNING=$(docker inspect -f '{{.State.Running}}' "$MSSQL_CONTAINER_ID")
if [ "$RUNNING" != "true" ]; then
  echo "❌ SQL Server container is NOT running. Logs:"
  docker logs "$MSSQL_CONTAINER_ID"
  exit 1
fi

echo "⏳ Waiting for SQL Server to accept connections..."

RETRIES=5
until sqlcmd -S mssql -U SA -P P@ssw0rd123 -Q "SELECT 1" > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "❌ Still waiting for SQL Server..."
  sleep 5
  ((RETRIES--))
done

if [ $RETRIES -eq 0 ]; then
  echo "❌ SQL Server container is running, but not responding. Logs:"
  docker logs "$MSSQL_CONTAINER_ID"
  exit 1
fi

echo "✅ SQL Server is ready. Running schema..."
sqlcmd -S mssql -U SA -P P@ssw0rd123 -d master -i /workspace/sql/schema.sql
