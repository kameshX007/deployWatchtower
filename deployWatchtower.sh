#!/bin/sh
#Checking & Removing existing container
echo "Checking if Watchtower already deployed...">deployWatchtower.log;
container=$(docker ps -q --filter ancestor=containrrr/watchtower )>>deployWatchtower.log;
[ -z "$container" ] && echo "No running container found">>deployWatchtower.log || docker rm -f $container;

#Checking whether username is passed to script
#A docker folder will be created inside this users home directory and container persistant data will be stored there
dockerUser=$1;
[ -z "$dockerUser" ] && echo "###Please pass username...!!!">>deployWatchtower.log && exit 0 || echo "Deploying for user $dockerUser">>deployWatchtower.log;
echo "Deploying Watchtower for user $dockerUser...">>deployWatchtower.log;

#Deploying container
sudo docker run -d --name=watchtower --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --debug --cleanup --schedule "0 0 1 * * *"
echo "###Watchtower deployment successfull...">>deployWatchtower.log;
exit 0
