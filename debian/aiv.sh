#!/bin/bash
exec /usr/bin/java --add-opens=java.base/java.nio=ALL-UNNAMED \
     --add-exports=java.base/sun.nio.ch=ALL-UNNAMED \
     --add-opens=java.base/sun.nio.ch=ALL-UNNAMED \
     --add-opens=java.base/sun.util.calendar=ALL-UNNAMED \
     -Dspring.config.location=/etc/aiv/econfig/application.yml \
     -Dloader.path=/var/lib/aiv/drivers \
     -cp /etc/aiv/econfig/:/var/lib/aiv/aiv.jar \
     org.springframework.boot.loader.launch.PropertiesLauncher
