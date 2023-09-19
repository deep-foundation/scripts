# if it fails you may be required to relogin or restart

docker run hello-world
docker rm $(docker ps -a -q --filter "ancestor=hello-world")