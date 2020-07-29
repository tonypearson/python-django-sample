#!/bin/bash
gunicorn --env DJANGO_SETTINGS_MODULE=pydjango.settings.prod pydjango.wsgi -b 0.0.0.0:8080
