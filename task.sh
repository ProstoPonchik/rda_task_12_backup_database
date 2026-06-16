#! /bin/bash

DB_USER="$DB_USER"
DB_PASSWORD="$DB_PASSWORD"

if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "DB_USER and DB_PASSWORD environment variables must be set"
  exit 1
fi

# Check if mysqldump is installed
if ! command -v mysqldump &> /dev/null; then
  echo "mysqldump could not be found. Please install it and try again."
  exit 1
fi

if ! command -v mysql > /dev/null; then
  echo "mysql could not be found. Please install it and try again."
  exit 1
fi

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=ShopDB.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReverse < ShopDB.sql

#only data dump for shopdbdevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=ShopDBDevelopment.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDBDevelopment.sql
