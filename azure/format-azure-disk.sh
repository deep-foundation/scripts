set -e

DISK="$1"

# format
sudo parted "/dev/${DISK}" --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs -f "/dev/${DISK}1"
sudo partprobe "/dev/${DISK}1"