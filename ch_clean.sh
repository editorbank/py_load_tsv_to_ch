set -e
[ -f "ch_docker.tmp" ] && docker="$(cat ch_docker.tmp)" || docker=$(podman --help >/dev/null 2>&1 && echo podman || echo docker)

# Удаление контейнеров и образов сделанных проектом
$docker ps -q -f "name=some-clickhouse-server" | xargs -r $docker rm -f || true
#$docker images -q clickhouse/clickhouse-server | xargs -r $docker rmi -f || true

# Удаление томов Clickhouse
[ -d ch_data.tmp ] && sudo rm -f -r ch_data.tmp || true
[ -d ch_logs.tmp ] && rm -f -r ch_logs.tmp || true
[ -f ch_docker.tmp ] && rm -f ch_docker.tmp || true

