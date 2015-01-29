FROM gliderlabs/alpine:3.1

RUN apk-install -X http://dl-4.alpinelinux.org/alpine/edge/testing \
        python3 \
        python3-dev \
        build-base \
    && pip3 install virtualenv \
    && echo "Dockerfile" >> /etc/buildfiles \
    && echo ".onbuild" >> /etc/buildfiles \
    && echo "requirements.txt" >> /etc/buildfiles

WORKDIR /app

ONBUILD COPY . /app
ONBUILD RUN /app/.onbuild || true
ONBUILD RUN virtualenv /env && /env/bin/pip install -r /app/requirements.txt

EXPOSE 8080
CMD ["/env/bin/python", "main.py"]
