FROM debian:12-slim
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk-headless \
    ca-certificates wget \
    && wget https://github.com/giap-aivhub/docker-aiv/releases/download/debian%2F6.3.6-1/aiv_6.3.6_all.deb \
    && dpkg -i aiv_6.3.6_all.deb \
    && rm -rf aiv_6.3.6_all.deb \
    && apt-get clean && rm -rf /var/lib/apt
ENTRYPOINT ["/usr/bin/aiv"]
