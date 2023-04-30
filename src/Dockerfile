ARG TARGET_PYTHON_VERSION=3.10
FROM python:$TARGET_PYTHON_VERSION-slim as uwsgibuild

RUN apt-get update \
    && apt-get -y install g++ \
    && rm -rf /var/lib/apt/lists/*
RUN pip install uwsgi
RUN rm -rf /usr/local/lib/python*/**/__pycache__

FROM python:$TARGET_PYTHON_VERSION-slim
ARG TARGET_PYTHON_VERSION

LABEL maintainer="Matthias Valvekens <dev@mvalvekens.be>"

# copy the entire package dir from the build image, discarding the
# unnecessary build deps/cache in the process
COPY --from=uwsgibuild \
    /usr/local/lib/python$TARGET_PYTHON_VERSION/site-packages \
    /usr/local/lib/python$TARGET_PYTHON_VERSION/site-packages
COPY --from=uwsgibuild /usr/local/bin/uwsgi /usr/local/bin/uwsgi

COPY default-uwsgi.ini /srv/default-uwsgi.ini
COPY run.sh /srv/run.sh

RUN groupadd -g 123 uwsgi \
    && useradd -s /bin/bash -u 123 -g uwsgi uwsgi


ENV UWSGI_INI=/srv/default-uwsgi.ini
ENV PORT=9001
ENV USER=uwsgi
ENV GROUP=uwsgi

WORKDIR /srv

CMD ["./run.sh"]
