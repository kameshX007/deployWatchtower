#!/bin/sh
echo "Checking if Watchtower already deployed...">deployWatchtower.log;
container=$(docker ps -q --filter ancestor=containrrr/watchtower )>>deployWatchtower.log;
[ -z "$container" ] && echo "No running container found">>deployWatchtower.log || docker rm -f $container;
echo "Deploying Watchtower...">>deployWatchtower.log;
sudo docker run -d --name=watchtower --restart=always -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --debug --cleanup --schedule "0 0 1 * * *"
echo "Watchtower deployment successfull...">>deployWatchtower.log;
exit 0
