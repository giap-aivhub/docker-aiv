#!/usr/bin/env bash
# RPM package build script for AIV application
[ "${DEBUG:-0}" -eq 0 ] || set -x

export VERSION=${VERSION:-1.0.0}
export RELEASE=${RELEASE:-1}

# Clean up any existing build directories
rm -rf ~/rpmbuild
rm -rf aiv-${VERSION}

# Create RPM build directory structure
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Create source directory
mkdir -p aiv-${VERSION}
cd aiv-${VERSION}

# Create application directory structure
mkdir -p opt/aiv/{config/drivers,repository/{econfig,Config,images,Default}}
mkdir -p var/lib/aiv
mkdir -p var/log/aiv
mkdir -p etc/systemd/system

# Copy necessary application files
cp ../aiv.jar opt/aiv/
cp -r ../config/drivers/* opt/aiv/config/drivers/
cp -r ../repository/econfig/* opt/aiv/repository/econfig/
cp -r ../repository/Config/* opt/aiv/repository/Config/
cp -r ../repository/images/* opt/aiv/repository/images/
cp -r ../repository/Default/* opt/aiv/repository/Default/

# Create default configuration with environment variable substitution
export aiv_base=/var/lib/aiv
export aiv_db_url=jdbc:postgresql://localhost:5432/postgres
export aiv_db_user=postgres
export aiv_db_password=postgres
export security_db_url=jdbc:postgresql://localhost:5432/postgres?currentSchema=security
export security_db_user=postgres
export security_db_password=postgres

# Apply configuration templates
envsubst < ../repository/econfig/application.yml > opt/aiv/repository/econfig/application.yml
sed -i 's,logDir: /var/lib/aiv/logs,logDir: /var/log/aiv,g' opt/aiv/repository/econfig/application.yml
sed -i 's,/opt/logs,/var/log/aiv,g' opt/aiv/repository/econfig/logback.xml

# Create systemd service file
cat > etc/systemd/system/aiv.service << 'EOF'
[Unit]
Description=AIV Application Service
After=network.target postgresql.service
Wants=postgresql.service

[Service]
Type=simple
User=aiv
Group=aiv
WorkingDirectory=/opt/aiv
ExecStart=/usr/bin/java -jar /opt/aiv/aiv.jar
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

# Environment variables
Environment=JAVA_OPTS="-Xmx2g -Xms512m"
Environment=AIV_HOME=/opt/aiv
Environment=AIV_DATA=/var/lib/aiv
Environment=AIV_LOGS=/var/log/aiv

[Install]
WantedBy=multi-user.target
EOF

# Create the source tarball
cd ..
tar czf ~/rpmbuild/SOURCES/aiv-${VERSION}.tar.gz aiv-${VERSION}

# Generate RPM spec file
cat > ~/rpmbuild/SPECS/aiv.spec << EOF
Name:           aiv
Version:        ${VERSION}
Release:        ${RELEASE}%{?dist}
Summary:        AIV Application Package
License:        Proprietary
URL:            https://github.com/your-org/aiv
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

Requires:       java-17-openjdk
Requires:       postgresql-server
Requires:       systemd

%description
AIV is a comprehensive application for data processing and analysis.
This package contains the AIV application server and related components.

%prep
%setup -q

%build
# No build step needed for Java application

%install
rm -rf %{buildroot}

# Create directory structure
mkdir -p %{buildroot}/opt/aiv
mkdir -p %{buildroot}/var/lib/aiv
mkdir -p %{buildroot}/var/log/aiv
mkdir -p %{buildroot}/etc/systemd/system

# Copy application files
cp -r opt/aiv/* %{buildroot}/opt/aiv/
cp etc/systemd/system/aiv.service %{buildroot}/etc/systemd/system/

%files
%defattr(-,root,root,-)
/opt/aiv/
/etc/systemd/system/aiv.service
%attr(755,aiv,aiv) /var/lib/aiv
%attr(755,aiv,aiv) /var/log/aiv

%pre
# Create aiv user and group if they don't exist
getent group aiv >/dev/null || groupadd -r aiv
getent passwd aiv >/dev/null || useradd -r -g aiv -d /opt/aiv -s /bin/false aiv

%post
# Reload systemd and enable service
systemctl daemon-reload
systemctl enable aiv.service

# Set proper ownership
chown -R aiv:aiv /opt/aiv
chown -R aiv:aiv /var/lib/aiv
chown -R aiv:aiv /var/log/aiv

%preun
# Stop and disable service before removal
if [ \$1 -eq 0 ]; then
    systemctl stop aiv.service
    systemctl disable aiv.service
fi

%postun
# Reload systemd after removal
systemctl daemon-reload

# Remove user and group if package is completely removed
if [ \$1 -eq 0 ]; then
    userdel aiv 2>/dev/null || true
    groupdel aiv 2>/dev/null || true
fi

%clean
rm -rf %{buildroot}

%changelog
* $(date +'%a %b %d %Y') GitHub Actions <github-actions@users.noreply.github.com> - ${VERSION}-${RELEASE}
- Automated build from GitHub Actions

EOF

# Build the RPM package
rpmbuild -ba ~/rpmbuild/SPECS/aiv.spec

# Copy the built RPM to current directory
cp ~/rpmbuild/RPMS/noarch/aiv-${VERSION}-${RELEASE}*.rpm ./

echo "RPM package built successfully:"
ls -la *.rpm
