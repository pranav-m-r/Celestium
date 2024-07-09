import sqlite3
import requests
from bs4 import BeautifulSoup

def getData(year, db_filename):

    url = f'http://www.seasky.org/astronomy/astronomy-calendar-{year}.html'

    response = requests.get(url)
    html_content = response.content
    soup = BeautifulSoup(html_content, 'html.parser')
    event_paragraphs = soup.find_all('p')

    events = []
    events_desc = []

    for p in event_paragraphs:
        event_text = p.get_text().strip()
        for i in ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']:
            if i in event_text:
                events.append(event_text)

    for i in range(len(events)):
        temp = events[i].split('.', maxsplit=1)
        events[i] = temp[0].strip()
        events_desc.append(('.'.join(temp[1:len(temp)])).strip())
    
    print(events)
    print(events_desc)

    conn = sqlite3.connect(db_filename)
    cursor = conn.cursor()
    table_name = 'sc' + str(year)

    columns = "event TEXT, desc TEXT"
    cursor.execute(f"DROP TABLE {table_name}")
    cursor.execute(f"CREATE TABLE {table_name} ({columns})")

    for i in range(len(events)):
        cursor.execute(f"INSERT INTO {table_name} VALUES (?, ?)", [events[i].strip(), events_desc[i].strip()])

    conn.commit()
    conn.close()

year = 2020
db_filename = 'database.db'
getData(year, db_filename)