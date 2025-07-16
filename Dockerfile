FROM debian:12-slim
ENV AIV_VERSION=6.3.6-2
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk-headless \
    ca-certificates wget \
    && wget -O aiv.deb https://github.com/giap-aivhub/docker-aiv/releases/download/debian%2F${AIV_VERSION}/aiv_${AIV_VERSION}_all.deb \
    && dpkg -i aiv.deb \
    && rm -rf aiv.deb \
    && apt-get clean && rm -rf /var/lib/apt
ENTRYPOINT ["/usr/bin/aiv"]
