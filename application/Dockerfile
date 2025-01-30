FROM oraclelinux:8-slim AS jre

# Set environment variables for OpenJDK installation
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install runtime dependencies
RUN microdnf install -y \
    curl \
    ca-certificates \
    tar \
    gzip \
	freetype \
    fontconfig \
    dejavu-sans-fonts \
  && microdnf clean all

# Set up font configuration
RUN mkdir -p /usr/share/fonts/truetype/dejavu \
    && fc-cache -fv \
    && ln -sf /usr/share/fonts /etc/fonts

# Detect architecture and install Java
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
        url="https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_linux-x64_bin.tar.gz"; \
        sha256="7e80146b2c3f719bf7f56992eb268ad466f8854d5d6ae11805784608e458343f"; \
    elif [ "$arch" = "aarch64" ]; then \
        url="https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_linux-aarch64_bin.tar.gz"; \
        sha256="f5e4e4622756fafe05ac0105a8efefa1152c8aad085a2bbb9466df0721bf2ba4"; \
    else \
        echo "error: unsupported architecture: $arch"; \
        exit 1; \
    fi && \
    curl -L -o openjdk-21.tar.gz "$url" && \
    echo "$sha256  openjdk-21.tar.gz" | sha256sum --check && \
    mkdir -p ${JAVA_HOME} && \
    tar -xzf openjdk-21.tar.gz -C ${JAVA_HOME} --strip-components=1 && \
    rm openjdk-21.tar.gz

# (Optional) Set Java alternatives
RUN alternatives --install /usr/bin/java java "${JAVA_HOME}/bin/java" 20000 && \
    alternatives --install /usr/bin/javac javac "${JAVA_HOME}/bin/javac" 20000


# Final stage
FROM jre AS final

# Remove unneeded packages from final image
RUN microdnf remove -y tar gzip && \
    microdnf clean all

# Copy your built JAR into the container
WORKDIR /opt
COPY aiv.jar /opt/run.jar

# Expose port (adjust according to your Spring Boot config)
EXPOSE 8080

# If you have container-friendly Java flags, you can set them via ENV
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75.0"
ENV aiv_base=/opt
