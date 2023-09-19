DOCKER_ROOT="$1"
DOCKER_CONFIG="/etc/docker/daemon.json"

sudo service docker stop

# update configuration
if [ -s $DOCKER_CONFIG ]; then
  DOCKER_PREVIOUS_ROOT=$(sudo cat $DOCKER_CONFIG | sudo jq -r '.["data-root"]')
  sudo cat $DOCKER_CONFIG | sudo jq -carM ".[\"data-root\"] = \"$DOCKER_ROOT\"" | sudo tee $DOCKER_CONFIG
else
  DOCKER_PREVIOUS_ROOT="/var/lib/docker"
  echo "{ \"data-root\": \"$DOCKER_ROOT\" }" | sudo tee $DOCKER_CONFIG
fi

# move files
sudo rsync -aP "$DOCKER_PREVIOUS_ROOT/" "$DOCKER_ROOT"
sudo rm -rf "$DOCKER_PREVIOUS_ROOT"

sudo service docker start