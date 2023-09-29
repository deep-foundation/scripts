df -h
sudo systemctl stop docker
sudo find '/data/docker/containers/.' -name '*-json.log' -delete
sudo systemctl start docker
df -h
