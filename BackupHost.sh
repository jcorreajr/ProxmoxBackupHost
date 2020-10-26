#!/bin/bash
# Baseado no script: https://github.com/DerDanilo/proxmox-stuff/
#

# Variáveis
usuariopbs="root@pam"
ippbs="192.168.100.240"
datastorepbs="DestinoBackup"

# Iniciando backup

# Backup Conf
proxmox-backup-client backup proxmoxEtc.pxar:/etc proxmoxRoot.pxar:/root proxmoxLib.pxar:/var/lib/pve-cluster --include-dev /etc/pve --verbose --repository $usuariopbs@$ippbs:$datastorepbs

# Backup de /var/lib/vz
## proxmox-backup-client backup proxmoxVz.pxar:/var/lib/vz --verbose --repository $usuariopbs@$ippbs:$datastorepbs
