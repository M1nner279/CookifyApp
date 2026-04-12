/opt/mssql/bin/sqlservr &

for i in {1..50}; do
    if /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT 1" > /dev/null 2>&1; then
        echo "SQL Server is up!"
        break
    fi
    echo "Still waiting... ($i)"
    sleep 2
done

/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -i /var/opt/mssql/backup/restore-db.sql

wait