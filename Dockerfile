FROM alpine:3.10

ENV TZ=America/Sao_Paulo
ENV PYTHONUNBUFFERED=1

RUN set -x \
    && apk add --no-cache --virtual .run-deps python3 libffi openssl openssh ca-certificates tzdata \
    && apk add --no-cache --virtual .build-deps python3-dev musl-dev gcc libffi-dev openssl-dev make \
    && pip3 install --upgrade pip \
    && pip3 install fabric3 \
    && rm -rf /root/.cache /tmp/* /src \
    && apk del .build-deps
    
