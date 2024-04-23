set -ex

./ch_init.sh && \
./py_init.sh && \
echo OK || echo FAIL
