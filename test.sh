#!/bin/bash

#tail /var/log/messages > $1
grep -v kernel /var/log/messages > /tmp/rapport.txt

egrep '/etc|passwd|aptitude|install|su|sudo|/etc/shadow/|export|chmod|chown|env|export' /tmp/rapport.txt > rapport 

hote_db="localhost"
login_db="root"
nom_db="projetlinux"
nom_table="commande"


query1="CREATE DATABASE IF NOT EXISTS projetlinux;"
query2="CREATE TABLE IF NOT EXISTS commande (
                date VARCHAR(30),
                nom VARCHAR(30),
                path VARCHAR(50),
                command VARCHAR(50));"
#queryDELETE="DROP TABLE commande"


#mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$queryDELETE"
mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query1"
mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query2"

for i in `cut -d' ' -f1,2,3 rapport`
do
    echo $i > tmp

    date=$(cut -d' ' -f1,2,3 rapport)
    user=$(cut -d' ' -f5 rapport | cut -d'[' -f1)
    path=$(cut -d'[' -f2 rapport | cut -d']' -f1)
    command=$(cut -d: -f4 rapport)
done

query3="insert into commande values ('$date', '$user', '$path', '$commande')"

mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query3"
