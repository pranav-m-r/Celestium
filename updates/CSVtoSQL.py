import csv
import sqlite3

# Tables: stars, messier, planets, explorium

def csv_to_sqlite(csv_filename, db_filename):
    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()

    with open(csv_filename, 'r', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        headers = next(reader)

        table_name = "explorium"
        columns = ', '.join([f"{header} TEXT" for header in headers])
        cursor.execute(f"DROP TABLE {table_name}")
        cursor.execute(f"CREATE TABLE {table_name} ({columns})")

        placeholders = ', '.join(['?'] * len(headers))
        for row in reader:
            cursor.execute(f"INSERT INTO {table_name} VALUES ({placeholders})", row)

    conn.commit()
    conn.close()


csv_filename = 'ExploriumData.csv'
db_filename = 'database.db'
csv_to_sqlite(csv_filename, db_filename)