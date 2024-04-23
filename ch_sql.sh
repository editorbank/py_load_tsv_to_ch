set -e
[ -z "$1" ] && ( 2>&1 echo "Use: $0 <filename.sql> | \"sql command\"" ; exit 1 )
( [ -f "$1" ] && cat "$1" || echo "$*" ) | curl -k --fail-with-body -s --data-binary @- \
  "http://localhost:8123/?database=ch_database&user=ch_username&password=ch_password&default_format=PrettyCompactNoEscapes&query="
