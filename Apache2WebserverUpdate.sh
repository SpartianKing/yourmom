#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "ERROR: This script must be run as root" 2>&1
  exit 1
fi

clear

dialog --title "Apache2 Webserver Repair" \
--msgbox "
       Removing Apache2...

" 12 48

exec apt-get --purge remove apache2

clear

dialog --title "Apache2 Webserver Repair" \
--msgbox "
        Installing autoremove...
" 12 48

exec apt-get autoremove

clear

dialog --title "Apache2 Webserver Repair" \
--msgbox "
    Installing Java 17 JRE...
    " 12 48

exec apt install -y libc6-x32 libc6-i386

exec apt install -y openjdk-17-jre

exec apt install -y openjdk-17-jdk

exec update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-17/bin/java 1

clear

dialog --title "Apache2 Webserver Repair" \
--msgbox "
    Done! Installing Apache2 and restarting
        Apache2...
        " 12 48

exec apt-get install apache2

exec /etc/init.d/apache2 restart

clear