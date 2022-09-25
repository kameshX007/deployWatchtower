#!/bin/sh
#Checking whether username is passed to script
#A docker folder will be created inside this users home directory and container persistant data will be stored there
dockerUser=$1;
[ -z "$dockerUser" ] && echo "Please pass username...!!!" && exit 0 || echo "Deploying Watchtower for user $dockerUser";

#Checking & Removing existing container
echo "Checking if Watchtower already deployed...";
container=$(docker ps -q --filter ancestor=containrrr/watchtower );
echo $container;
[ -z "$container" ] && echo "No running container found" || docker rm -f $container;

#Deploying container
docker run -d --name=watchtower --network tunnel --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --debug --cleanup --schedule "@hourly"
echo "Watchtower deployment successfull...";
exit 0