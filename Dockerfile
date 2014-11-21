FROM ubuntu-debootstrap

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y -q build-essential python2.7 python2.7-dev python-pip && \
    apt-get clean && \
    pip install -U pip && \
    hash -r && \
    pip install virtualenv

WORKDIR /app

ONBUILD ADD . /app
ONBUILD RUN /app/.onbuild || true
ONBUILD RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt

EXPOSE 8080
CMD ["/env/bin/python", "main.py"]
