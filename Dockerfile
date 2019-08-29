FROM docker:stable-dind

ENV TZ=America/Sao_Paulo
ENV TERRAFORM_VERSION=0.12.7
ENV PYTHONUNBUFFERED=1

ADD https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl /usr/local/bin/kubectl


RUN set -x \
    && apk add --no-cache gzip tar zip bash python3 libffi openssl openssh ca-certificates tzdata curl wget git \
    && apk add --no-cache coreutils whois sudo gnupg unzip libc6-compat \
    && apk add --no-cache --virtual .build-deps python3-dev musl-dev gcc libffi-dev openssl-dev make \
    && pip3 install --upgrade pip \
    && pip3 install fabric3 docker-compose awscli \
    && rm -rf /root/.cache /tmp/* /src \
    && apk del .build-deps \
    && chmod +x /usr/local/bin/kubectl \
    && rm -rf /var/cache/apk/* \
    && true
    
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
