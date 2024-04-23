set -e

[ ! -d .venv ] || ( 
  echo Remove .venv dir ...
  rm -rf .venv
)

[ ! -f .venv ] || ( 
  echo Remove .venv dir ...
  rm -rf .venv
)

# Удаление игнорируемых Git-ом файлов кроме *.bak (как файлов так и директорий) И Удаление только пустых директорий
git ls-files --others --ignored --exclude-standard 2>/dev/null | grep -v .bak | xargs -r -i{} rm "{}" || true
find . -empty -type d -delete 2>/dev/null || true
