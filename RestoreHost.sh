#!/bin/bash

# Variaveis
snap="host/pveb2/2020-07-29T17:24:14Z"
usuariopbs="root@pam"
ippbs="192.168.100.240"
datastorepbs="DestinoBackup"

# Parar serviços
echo "------------ Parando serviços ------------------------"
for i in pve-cluster pvedaemon vz qemu-server; do systemctl stop $i ; done

# Exibindo backups
echo "----------- Exibindo backups --------------"
proxmox-backup-client snapshots --repository $usuariopbs@$ippbs:$datastorepbs
echo "Enter para continuar..."
read

# Restaurando ETC
echo "----------------- Restaurando Etc --------------"
proxmox-backup-client restore $snap proxmoxEtc.pxar /restaurar/etc --repository $usuariopbs@$ippbs:$datastorepbs
echo ".. ETC Restaurado. Enter p/ continuar"
read

# Restaurando Lib
echo "----------------- Restaurando Lib -----------------"
proxmox-backup-client restore $snap proxmoxLib.pxar /restaurar/pve-cluster --repository $usuariopbs@$ippbs:$datastorepbs
echo ".. LIB Restaurado. Enter p/ continuar"
read

# Restaurando Root
echo "----------------- Restaurando Root -----------------"
proxmox-backup-client restore $snap proxmoxRoot.pxar /restaurar/root --repository $usuariopbs@$ippbs:$datastorepbs
echo ".. ROOT Restaurado. Enter p/ continuar"
read

# Copiando arquivos
echo "----------------- Copiando arquivos -----------------"
cp -avr /restaurar/etc /
echo "ETC copiado. Enter p/ continuar"
read

cp -avr /restaurar/root /
echo "ROOT copiado. Enter p/ continuar"
read

cp -avr /restaurar/pve-cluster /var/lib/
echo "pve-cluster copiado. Enter p/ continuar"
read

echo "------------ Iniciando serviços ------------------------"
for i in pve-cluster pvedaemon vz qemu-server; do systemctl start $i ; done
echo "Enter para continuar"
read

# Iniciar o cluster
echo "Fazendo alteração para iniciar o cluster não vazio"
mv /etc/pve /etc/pve.bak
systemctl restart pve-cluster
echo "Finalizado.... Enter para fechar"
read

echo "----------------- FIM -----------------"
