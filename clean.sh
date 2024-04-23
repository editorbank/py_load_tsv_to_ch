set -ex

./ch_clean.sh && \
./py_clean.sh && \
echo OK || echo FAIL
