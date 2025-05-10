# GitHub Copilot SQL Demo (Codespaces Ready)

This repository is designed for showcasing how to use **GitHub Copilot with SQL development** in a fully self-contained **GitHub Codespaces** environment.

It features:
- ✅ GitHub Copilot for SQL prompt assistance
- ✅ SQL Server 2022 running in a container
- ✅ Preloaded database schema with sample data
- ✅ Post-create automation to initialize the environment
- ✅ Follow-along demo support for workshops or livestreams

---

## 🚀 Getting Started

1. **Open in GitHub Codespaces** (from the Code dropdown > Codespaces tab)
2. The container will:
   - Launch SQL Server as a service
   - Load the schema from `sql/schema.sql`
3. Open `*.sql` files and start prompting Copilot (e.g., write `SELECT` then press `Tab`)

---

## 💡 Sample Database Schema

- `Customers`
- `Orders`
- `OrderLines`

All preloaded into a `SalesDB` database, ready for queries like:

```sql
-- How many orders did each customer place?
SELECT c.Name, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name;
```

---

## 🛠️ Development Notes

- SQL Server is available at host: `mssql`, port: `1433`
- Login: `SA`, Password: `P@ssw0rd`
- To connect manually:

```bash
sqlcmd -S mssql -U SA -P P@ssw0rd -Q "SELECT @@VERSION"
```

---

## 🧠 Ideas for Copilot Prompts

You can ask Copilot to:
- Suggest joins across `Customers`, `Orders`, `OrderLines`
- Write aggregates (e.g. total revenue per region)
- Generate insert/update/delete queries
- Refactor queries into CTEs

---

## 📦 Project Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json         # Main Codespaces config
│   └── post-create.sh            # Waits for SQL, runs schema
├── sql/
│   └── schema.sql                # SalesDB structure + sample data
└── README.md
```

---

## 🧪 Copilot Agent Mode (optional)

This project is also suited for experimenting with **GitHub Copilot Agent Mode**, by connecting it to this database via command-line or notebook-style prompts.

---

## 🧯 Troubleshooting

- If schema isn't loaded, run manually:
  ```bash
  sqlcmd -S mssql -U SA -P P@ssw0rd -d master -i /workspace/sql/schema.sql
  ```

- If SQL Server doesn't respond, check container logs:
  ```bash
  docker logs $(docker ps -aqf "name=mssql")
  ```

---

## 🙏 Credits

Created for educational workshops, internal tech talks, and GitHub Copilot demos with a focus on SQL development workflows.

---

> 💬 Feel free to fork and adapt this repo for your own SQL datasets or demo needs!
