FROM krallin/ubuntu-tini:xenial

ENV TERM=ansi DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
ENV PATH /opt/puppetlabs/bin:/bin/:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

RUN apt-get update
RUN apt-get install -y libltdl7 wget curl httpie iproute2 && \
    apt-get clean all && \
    rm -rf /var/cache/apt

COPY ./binaries/vault /usr/local/bin/vault
ENTRYPOINT ["/usr/local/bin/tini", "--", "/usr/local/bin/vault", "server", "-dev"]

COPY Dockerfile /Dockerfile
