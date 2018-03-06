FROM docker:stable-dind
MAINTAINER Archii
LABEL Description='Setup for the Integration testing environment'

ADD . /archii-int-test
WORKDIR /archii-int-test

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add vim && \
    apk add sudo && \
    apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && \
    pip install -r requirements.txt
ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
