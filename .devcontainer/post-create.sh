#!/bin/bash

echo "⏳ Waiting for SQL Server to start..."
sleep 20

echo "🚀 Running schema.sql..."
sqlcmd -S localhost -U SA -P P@ssw0rd123 -d master -i /workspace/sql/schema.sql
