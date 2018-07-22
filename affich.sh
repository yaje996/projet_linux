#!/bin/bash

#date=$(cut -d' ' -f1,2,3 rapport)
user=$(cut -d' ' -f5 rapport | cut -d'[' -f1)
command=$(cut -d: -f4 rapport)
path=$(cut -d'[' -f2 rapport | cut -d']' -f1)
#command=$(cut -d: -f4 rapport)

for i in $user
do
#    echo "$i"

    for j in $command
    do
	echo "$i : $j"
    done
done

