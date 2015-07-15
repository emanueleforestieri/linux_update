    #!/bin/bash
    RED_TEXT=`echo "\033[31m"`
    YELLOW_TEXT=`echo "\033[33m"`
    NORMAL_TEXT=`echo "\033[m"`
    function update() {
      apt-get update
    }
    function upgrade() {
      apt-get -y upgrade
    }
    function dist_upgrade() {
      apt-get -y dist-upgrade
    }
    if [ `whoami` == "root" ]; then
      echo -e "${YELLOW_TEXT}[*] Aggiornamenti in corso...${NORMAL_TEXT}"
      update;
      upgrade;
      dist_upgrade;
      echo -e "${YELLOW_TEXT}[+] Distro aggiornata!"
    else
      echo -e "${RED_TEXT}[!] Aggiorna_D deve essere eseguito come root!"
    fi

