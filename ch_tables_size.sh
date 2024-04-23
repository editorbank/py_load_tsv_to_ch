(cat <<EOF
SELECT
    database,
    table,
    formatReadableSize(sum(data_compressed_bytes) AS size) AS compressed,
    formatReadableSize(sum(data_uncompressed_bytes) AS usize) AS uncompressed,
    round(usize / size, 2) AS compr_rate,
    sum(rows) AS rows,
    count() AS part_count
FROM system.parts
WHERE (active = 1) AND (database LIKE '%') AND (table LIKE '%')
GROUP BY
    database,
    table
ORDER BY size DESC
--FORMAT PrettyCompact
--FORMAT JSONCompact
;
EOF
) | curl -k --fail-with-body  -s --data-binary @- \
  "http://localhost:8123/?database=ch_database&user=ch_username&password=ch_password&default_format=PrettyCompactNoEscapes&query="
