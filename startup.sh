#!/usr/bin/env bash
set -e

# Move to site root where App Service runs the code
cd /home/site/wwwroot

# Run DB migrations and collect static
python manage.py migrate --noinput
python manage.py collectstatic --noinput

# Start gunicorn (bind to 0.0.0.0:8000 on App Service Linux)
exec gunicorn horilla.wsgi:application --bind=0.0.0.0:8000 --workers=4 --timeout=120
