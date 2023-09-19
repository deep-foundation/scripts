# Prepare server
1. Get list of disks:

```
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
```

2. Output will be like this:

```
deep@deep:~$ lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
sda     1:0:0:0      128G 
sdb     0:0:0:0       30G 
├─sdb1              29.9G /
├─sdb14                4M 
└─sdb15              106M /boot/efi

```

3. Choose disk, for example `sda`

4. Attach

```sh
wget https://raw.githubusercontent.com/deep-foundation/scripts/main/azure/format-azure-disk.sh && chmod +x format-azure-disk.sh
wget https://raw.githubusercontent.com/deep-foundation/scripts/main/azure/attach-azure-disk.sh && chmod +x attach-azure-disk.sh

sudo ./format-azure-disk.sh sda
sudo ./attach-azure-disk.sh sda xfs /data
```

5. Deatach if needed (for example to attach it to another VM)

```sh
wget https://raw.githubusercontent.com/deep-foundation/scripts/main/azure/detach-azure-disk.sh && chmod +x detach-azure-disk.sh

sudo ./detach-azure-disk.sh sda /data
```