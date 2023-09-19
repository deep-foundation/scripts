# format-azure-disk.sh

```
export SCRIPT_NAME="format-azure-disk.sh"; touch $SCRIPT_NAME && chmod +x $SCRIPT_NAME && nano $SCRIPT_NAME
```

```sh
set -e

DISK="$1"

# format
sudo parted "/dev/${DISK}" --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs -f "/dev/${DISK}1"
sudo partprobe "/dev/${DISK}1"
```

# attach-azure-disk.sh

https://github.com/deep-foundation/scripts/blob/7cf0e5152f410eef750e2cf1148fd33db9c0f060/azure/attach-azure-disk.sh#L1-L18

# detach-azure-disk.sh

https://github.com/deep-foundation/scripts/blob/main/azure/detach-azure-disk.sh#L1-L16

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
