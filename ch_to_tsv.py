import clickhouse_connect



if __name__ == '__main__':
    client = clickhouse_connect.get_client(host='localhost', port=8123, username='ch_username', password='ch_password', database='ch_database')
    #client.command("SET format_csv_delimiter = '\t'")

    query = 'SELECT number+number, toString(number)||toString(number) AS number_as_str FROM system.numbers LIMIT 50'
    #fmt = 'CSVWithNames'  # or CSV, or CSVWithNamesAndTypes, or TabSeparated, etc.
    fmt = 'TabSeparatedWithNames'
    stream = client.raw_stream(query=query, fmt=fmt)
    with open("test.tsv.tmp", "wb") as f:
        for chunk in stream:
            f.write(chunk)