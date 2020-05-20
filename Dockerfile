FROM python:3.6-alpine
MAINTAINER arnaud.clauss78@gmail.com

RUN apk --no-cache add git

RUN apk --no-cache add --virtual build-dependencies \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base && \
    pip install ansible==2.8.8 ansible-lint && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

RUN wget -P /tmp https://networkgenomics.com/try/mitogen-0.2.9.tar.gz && \
    tar -zxf /tmp/mitogen-0.2.9.tar.gz --directory /opt && \
    rm -f /tmp/mitogen-0.2.9.tar.gz

RUN mkdir /ansible && \
    mkdir -p /etc/ansible

COPY ansible.cfg /etc/ansible/ansible.cfg

WORKDIR /ansible
