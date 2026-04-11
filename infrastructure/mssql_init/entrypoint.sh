# Запускаем SQL Server в фоновом режиме
/opt/mssql/bin/sqlservr &

# Ждем 30 секунд, пока сервер поднимется
for i in {1..50}; do
    # Добавлен флаг -C
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -Q "SELECT 1" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "SQL Server is up!"
        break
    fi
    echo "Still waiting..."
    sleep 2
done

# Запуск скрипта восстановления
# Добавлен флаг -C
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -i /var/opt/mssql/backup/restore-db.sql

# Оставляем процесс активным
wait