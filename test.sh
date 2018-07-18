#!/bin/bash

#tail /var/log/messages > $1
cat /var/log/messages > /tmp/rapport.txt

egrep '/etc|passwd|aptitude|install|su|sudo|/etc/shadow/|export|chmod|chown|env|export' /tmp/rapport.txt > rapport

hote_db="localhost"
login_db="root"
nom_db="projet_linux"
nom_table="commande"


query1="CREATE DATABASE IF NOT EXISTS projet_linux;"
query2="CREATE TABLE IF NOT EXISTS commande (
                date VARCHAR(30),
                nom VARCHAR(30),
                path VARCHAR(50),
                command VARCHAR(50));"

for i in `cut -d' ' -f1 rapport`
do
    echo $i > tmp

    #date=$(cut -d' ' -f1,2,3 rapport)
    user=$(cut -d' ' -f5 rapport | cut -d'[' -f1)
   # path=$(cut -d'[' -f5 rapport | cut -d']' -f1)
    #command=$(cut -d: -f4 rapport)
done

echo $user
