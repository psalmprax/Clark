FROM python:3.7-buster

ENV DEBIAN_FRONTEND=noninteractive \
    AIRFLOW_HOME='/usr/local/airflow'

RUN apt-get update \
&&  apt-get upgrade -qqy \
&&  apt-get install -y --no-install-recommends \
    build-essential \
    freetds-bin \
    krb5-user \
    ldap-utils \
    libffi6 \
    libsasl2-2 \
    libsasl2-modules \
    libssl1.1 \
    locales  \
    lsb-release \
    sasl2-bin \
    sqlite3 \
    unixodbc \
    default-libmysqlclient-dev \
    wait-for-it
# start new context to speed up rebuilds
RUN pip install --upgrade pip \
                setuptools \
                apache-airflow[mysql,postgres]==2.0.0
# this was needed after a few weeks, see
# https://stackoverflow.com/questions/66644975/importerror-cannot-import-name-columnentity-from-sqlalchemy-orm-query
COPY requirements.txt requirements_2.txt
# RUN cat requirements.txt requirements_2.txt > requirements.txt

RUN echo "sqlalchemy < 1.4.0" > requirements.txt \
&& pip install -r requirements.txt \
&& pip install -r requirements_2.txt \
&&  rm -rf /root/.cache \
&&  apt-get remove -qqy --purge \
            build-essential \
&&  apt-get -qqy autoremove --purge
# RUN pip install -r requirements_2.txt
COPY ./configurations /usr/local/airflow/configurations
RUN mkdir -p /usr/local/airflow/__logger
RUN mkdir -p /usr/local/airflow/file_temp_store
COPY events.json /usr/local/airflow/events.json
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
