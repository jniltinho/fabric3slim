FROM alpine:3.10

ENV PYTHONUNBUFFERED=1

RUN set -x \
    && apk add --no-cache --virtual .run-deps python3 libffi openssl openssh ca-certificates \
    && apk add --no-cache --virtual .build-deps python3-dev musl-dev gcc libffi-dev openssl-dev make \
    && pip3 install --upgrade pip \
    && pip3 install fabric3 \
    && apk del .build-deps \
    && mkdir /root/.ssh
