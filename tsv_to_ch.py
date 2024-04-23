import clickhouse_connect
from clickhouse_connect.driver.tools import insert_file

create_table="""
CREATE TABLE IF NOT EXISTS sometable
(
    `number` UInt32,
    `number_as_str` String
)
ENGINE = MergeTree
ORDER BY number
"""
truncate_table="""
TRUNCATE TABLE sometable
"""


if __name__ == '__main__':
    client = clickhouse_connect.get_client(host='localhost', port=8123, username='ch_username', password='ch_password', database='ch_database')
    client.command(create_table)
    client.command(truncate_table)
    #client.command("SET format_csv_delimiter = '\t'")

    insert_file(client, 'sometable', 'test.tsv.tmp', 'TabSeparatedWithNames',
                settings={'input_format_allow_errors_ratio': .2,
                          'input_format_allow_errors_num': 5,
                          'input_format_with_names_use_header': 1,
                          'input_format_skip_unknown_fields': 1
                          })
