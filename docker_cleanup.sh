mlinarik@dockerdev:~$ cat docker_cleanup 
#!/bin/bash

echo "1) Delete Volumes"
echo "2) Delete Networks"
echo "3) Delete Images"
echo "4) Delete Containers"

echo "Select Option: "
read option

if [[ $option -eq 1 ]];
then
    echo "Volume Delete"
    docker volume ls -qf dangling=true | xargs -r docker volume rm
elif [[ $option -eq 2 ]];
then
    echo "Network Delete"
    docker network rm $(docker network ls | grep "bridge" | awk '/ / { print $1 }')
elif [[ $option -eq 3 ]];
then
    echo "Image Delete"
    docker rmi $(docker images | grep "none" | awk '/ / { print $3 }')
    docker image prune -a
elif [[ $option -eq 4 ]];
then
    echo "Containers Delete"
    docker rm $(docker ps -qa --no-trunc --filter "status=exited")
else
   echo "Invalid Selection"
fi
