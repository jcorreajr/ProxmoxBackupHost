#!/bin/bash
# Baseado no script: https://github.com/DerDanilo/proxmox-stuff/
#

# Variáveis
usuariopbs="root@pam"
ippbs="192.168.100.240"
datastorepbs="DestinoBackup"

# Colocar a senha do usuário de backup:
export PBS_PASSWORD="123456"


# Iniciando backup

# Backup Conf
SAIDA=`proxmox-backup-client backup proxmoxEtc.pxar:/etc proxmoxRoot.pxar:/root proxmoxLib.pxar:/var/lib/pve-cluster --include-dev /etc/pve --verbose --repository $usuariopbs@$ippbs:$datastorepbs`

# Enviando resultado por e-mail
echo "$SAIDA" | mail -s "Backup host $ippbs" email@dominio.com.br
# Resultado em tela
echo "$SAIDA"

# Backup de /var/lib/vz
## proxmox-backup-client backup proxmoxVz.pxar:/var/lib/vz --verbose --repository $usuariopbs@$ippbs:$datastorepbs
