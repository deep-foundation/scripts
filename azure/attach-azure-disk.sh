set -e

DISK="$1"
FS="$2"
DATA_DIR="$3"
DISK_UUID=$(sudo blkid | grep "/dev/${DISK}1" | cut -d " " -f 2 | cut -d "\"" -f 2)

# mount
sudo mkdir "${DATA_DIR}"
sudo mount "/dev/${DISK}1" "${DATA_DIR}"

# attach on system start up
FSTAB_LINE="UUID=${DISK_UUID}   ${DATA_DIR}   ${FS}   defaults,nofail   1   2"
sudo bash -c "echo \"$FSTAB_LINE\" >> /etc/fstab"

# check status
cat /etc/fstab
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"