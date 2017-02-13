.PHONY: web

web:
	python update-settings.py
	gunicorn --preload -w 4 isso.dispatch --log-file=- --access-logfile=-
