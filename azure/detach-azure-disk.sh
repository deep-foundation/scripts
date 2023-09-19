set -e

DISK="$1"
DATA_DIR="$2"
DISK_UUID=$(sudo blkid | grep "/dev/${DISK}1" | cut -d " " -f 2 | cut -d "\"" -f 2)

# unmount
sudo umount -l "/dev/${DISK}1"
sudo rm -r "${DATA_DIR}"

# detach from system start up
sudo sed --in-place "/${DISK_UUID}/d" /etc/fstab

# check status
cat /etc/fstab
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"