FROM registry.access.redhat.com/ubi8

WORKDIR /app

COPY Pipfile* /app/

## NOTE - rhel enforces user container permissions stronger ##
USER root
RUN yum -y install python3
RUN yum -y install python3-pip wget

RUN pip3 install --upgrade pip \
  && pip3 install --upgrade pipenv \
  && pipenv install --system --deploy

USER 1001

COPY . /app
CMD ["gunicorn", "-b", "0.0.0.0:3000", "--env", "DJANGO_SETTINGS_MODULE=pydjango.settings.prod", "pydjango.wsgi", "--timeout 120"]
