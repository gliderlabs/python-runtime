FROM ubuntu-debootstrap:trusty
MAINTAINER Glider Labs <team@gliderlabs.com>

ENV PYTHON_VERSION 2.7

RUN apt-get update -y \
    && apt-get install --no-install-recommends -y -q \
        build-essential python$PYTHON_VERSION python$PYTHON_VERSION-dev python-pip \
    && apt-get clean \
    && pip install -U pip \
    && hash -r \
    && pip install virtualenv \
    && echo "Dockerfile" >> /etc/buildfiles \
    && echo ".onbuild" >> /etc/buildfiles \
    && echo "requirements.txt" >> /etc/buildfiles

WORKDIR /app

ONBUILD COPY . /app
ONBUILD RUN /app/.onbuild || true
ONBUILD RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt

EXPOSE 8080
CMD ["/env/bin/python", "main.py"]
