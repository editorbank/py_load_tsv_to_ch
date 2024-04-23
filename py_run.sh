set -e
echo Activate virtual environment ...
[ -f .venv/bin/activate ] && source ".venv/bin/activate" || (echo ERROR: The virtual environment was not activated! ; exit 1)
set -ex
python ch_to_tsv.py
head -n4 test.tsv.tmp 
python tsv_to_ch.py
./ch_sql.sh "select count(1) from sometable"
echo $0 - OK