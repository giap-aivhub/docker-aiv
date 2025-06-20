#!/usr/bin/env bash
[ "${DEBUG:-0}" -eq 0 ] || set -x


# Create the package structure
mkdir -p aiv-build/var/lib/aiv/drivers
mkdir -p aiv-build/var/lib/aiv/repository/images
mkdir -p aiv-build/etc/aiv/econfig
mkdir -p aiv-build/var/logs/aiv
mkdir -p aiv-build/usr/share/aiv

# Copy DEBIAN
cp DEBIAN aiv-build/DEBIAN -a

cat > aiv-build/lib/systemd/system/aiv.service << 'EOF'
[Unit]
Description=AIV Spring Application
After=network.target

[Service]
User=aiv
Group=aiv
Type=simple
ExecStart=/usr/bin/aiv
WorkingDirectory=/var/lib/aiv
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF


# Copy the JAR file to the package structure
cp aiv.jar aiv-build/var/lib/aiv/aiv.jar
cp config/drivers/* aiv-build/var/lib/aiv/drivers/ -av
mkdir aiv-build/var/lib/aiv/repository/econfig/ -p
mkdir aiv-build/var/lib/aiv/repository/Config/ -p
mkdir aiv-build/etc/aiv/ -p
cp repository/econfig/* aiv-build/var/lib/aiv/repository/econfig/ -av
cp repository/Config/* aiv-build/var/lib/aiv/repository/Config/ -av
cp repository/images/* aiv-build/var/lib/aiv/repository/images/ -av
rm -rf aiv-build/etc/aiv/
mkdir aiv-build/etc/aiv/ -p
ln -svf /var/lib/aiv/repository/econfig/ aiv-build/etc/aiv/econfig
ln -svf /var/lib/aiv/repository/Config/ aiv-build/etc/aiv/Config



mkdir -p aiv-build/usr/bin

cat > aiv-build/usr/bin/aiv << 'EOF'
#!/bin/bash
exec /usr/bin/java --add-opens=java.base/java.nio=ALL-UNNAMED \
     --add-exports=java.base/sun.nio.ch=ALL-UNNAMED \
     --add-opens=java.base/sun.nio.ch=ALL-UNNAMED \
     --add-opens=java.base/sun.util.calendar=ALL-UNNAMED \
     -Dspring.config.location=/etc/aiv/econfig/application.yml \
     -Dloader.path=/var/lib/aiv/drivers \
     -cp /etc/aiv/econfig/:/var/lib/aiv/aiv.jar \
     org.springframework.boot.loader.launch.PropertiesLauncher
EOF
chmod 755 aiv-build/usr/bin/aiv


# Set correct permissions for all files
find aiv-build -type d -exec chmod 755 {} \;
find aiv-build -type f -exec chmod 644 {} \;
chmod 755 aiv-build/DEBIAN/postinst
chmod 755 aiv-build/DEBIAN/prerm
chmod 755 aiv-build/usr/bin/aiv

# Build the package
dpkg-deb -Zxz --build aiv-build
