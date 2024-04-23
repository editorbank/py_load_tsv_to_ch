set -e
[ -n "$1" ] && docker="$1" || docker=$(podman --help >/dev/null 2>&1 && echo podman || echo docker)
echo -e "$docker" >ch_docker.tmp

[ -d ch_data.tmp ] || ( mkdir ch_data.tmp && chmod a+rwx ch_data.tmp )
[ -d ch_logs.tmp ] || ( mkdir ch_logs.tmp && chmod a+rwx ch_logs.tmp )

$docker ps -q -a -f "name=some-clickhouse-server" | xargs -r $docker rm -f
$docker run -d --name some-clickhouse-server \
    --ulimit nofile=262144:262144 \
    -v $(realpath ch_data.tmp):/var/lib/clickhouse/ \
    -v $(realpath ch_logs.tmp):/var/log/clickhouse-server/ \
    -p 8123:8123/tcp \
    -p 9000:9000/tcp \
    -e CLICKHOUSE_DB=ch_database \
    -e CLICKHOUSE_USER=ch_username \
    -e CLICKHOUSE_PASSWORD=ch_password \
    -e CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1 \
    docker.io/clickhouse/clickhouse-server
