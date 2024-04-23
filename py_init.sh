set -e
echo Check virtual environment ...
[ -d .venv ] || python3 -m venv .venv || python3 -m vitualenv .venv || (echo ERROR:The virtual environment was not created! ; exit 1)
[ -f .venv/bin/activate ] && source ".venv/bin/activate" || (echo ERROR: The virtual environment was not activated! ; exit 1)

[ -f requirements.txt -a ! -f .venv/pip_freeze.log ] && (
  echo Install python packages ...
  pip install -r requirements.txt && pip freeze >.venv/pip_freeze.log
)
echo $0 - OK