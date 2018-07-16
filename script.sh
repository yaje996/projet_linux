#!/bin/sh

grep /home/ /etc/passwd > /tmp/tpmfile

hote_db="localhost"
login_db="root"
nom_db="projet_linux"
nom_table="users"

insert_system_users()
{
    query1="CREATE DATABASE IF NOT EXISTS projet_linux;"
    query2="CREATE TABLE IF NOT EXISTS users (
                uid INT(10) PRIMARY KEY,
                nom VARCHAR(30),
                gid VARCHAR(50),
                home VARCHAR(30),
                shell VARCHAR(30),
                taille VARCHAR(50),
                fingerprint VARCHAR(50));"
    
    #A utiliser pour supprimer la table:
    queryDELETE="DROP TABLE users;"
   
    mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query1"
    mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query2"

    for i in `cut -d: -f1,3,4,6,7 /tmp/tpmfile`
do
    echo $i>/tmp/tmpfile
    nom=$(cut -d: -f1 /tmp/tmpfile)
    home=$(cut -d: -f4 /tmp/tmpfile)
    uid=$(cut -d: -f2 /tmp/tmpfile)
    gid=$(cut -d: -f3 /tmp/tmpfile)
    shell=`cut -d: -f5 /tmp/tmpfile`

    if [[ -z "$(userExistinDB $uid)" ]]
    then
	echo "J'ajoute l'user $uid dans la bdd"
        query3="insert into users values ('$uid', '$nom', '$gid', '$home', '$shell', '$taille', '$fingerprint')"
	mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query3"
    fi

done
}

userExistinDB()
{
   uid=$1
   query4="SELECT uid FROM users WHERE uid=$uid;"
   mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query4"
}




#userExistinDB 100000
insert_system_users
rm /tmp/tmpfile

