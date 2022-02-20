#! /bin/bash
#! Need docker

tag='env:latest'
name='env'
docker --version
if [ $? -eq 0 ]; then
    filename=''
    for i in './env_overrided.dockerfile' './env_new.dockerfile' './env.dockerfile' './env_overrided' './env_new' './env' './dockerfile' './default'
    do
        if [ -f $i ]; then
            filename=$i
        fi
    done
    unset i
    if [ $filename != '' ]; then
        docker build -f $filename -t $tag .
        docker network create --subnet=172.18.0.0/16 network
        docker run -itd --privileged -v ~/workspace:/home:rw --net network --ip 172.18.0.2 --name $name $tag
    else
        echo "Not found docker file."
    fi
    unset filename
else
    echo "Docker is not installed."
fi
unset name
unset tag


