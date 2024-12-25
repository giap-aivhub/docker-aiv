FROM openjdk:17-oracle
ARG BUILDPLATFORM

WORKDIR /opt
RUN microdnf install jq
COPY aiv.jar /opt/run.jar

ENV aiv_base=/opt
EXPOSE 8080