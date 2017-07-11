FROM krallin/ubuntu-tini:xenial

ENV TERM=ansi DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
ENV PATH /opt/puppetlabs/bin:/bin/:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

RUN apt-get update
RUN apt-get install -y wget curl httpie && \
    apt-get clean all && \
    rm -rf /var/cache/apt

COPY ./binaries/consul /usr/local/bin/consul
ENTRYPOINT ["/usr/local/bin/tini", "--", "/usr/local/bin/consul", "agent", "-dev", "-client", "0.0.0.0"]

COPY Dockerfile /Dockerfile
