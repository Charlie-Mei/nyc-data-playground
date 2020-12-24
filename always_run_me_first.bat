REM navigate to directory
cd C:\Github\nyc-energy-dash

REM build environment
python -m venv .
call Scripts/activate.bat
call Scripts/Activate
call pip install -r requirements.txt

REM build package
