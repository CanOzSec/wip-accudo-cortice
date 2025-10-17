#!/bin/bash

mkdir /opt/symlinks/
export symlinksToCreate=$(sudo docker run --log-driver=none -a stdout --rm accudo-cortice ls -l /opt/symlinks | awk '{print $9}')


for i in $symlinksToCreate; do
	echo $i;
	ln -sf $PWD/wrapper.sh /opt/symlinks/$i;
done
