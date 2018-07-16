#!/bin/sh

grep /home/ /etc/passwd > /tmp/tpmfile

database()
{

    hote_db="localhost"
    login_db="root"
    nom_db="projet_linux"
    nom_table="users"
    query1="CREATE DATABASE IF NOT EXISTS projet_linux;"
    query2="CREATE TABLE IF NOT EXISTS users (
                id INT(6) AUTO_INCREMENT PRIMARY KEY,
                nom VARCHAR(30),
                uid VARCHAR(30),
                gid VARCHAR(50),
                home VARCHAR(30),
                shell VARCHAR(30),
                taille VARCHAR(50),
                fingerprint VARCHAR(50));"

    for i in `cut -d: -f1,3,4,6,7 /tmp/tpmfile`
do
    echo $i>/tmp/tmpfile
    nom=$(cut -d: -f1 /tmp/tmpfile)
    home=$(cut -d: -f4 /tmp/tmpfile)
    uid=$(cut -d: -f2 /tmp/tmpfile)
    gid=$(cut -d: -f3 /tmp/tmpfile)
    shell=`cut -d: -f5 /tmp/tmpfile`

    echo $home
    echo $nom

    query3="insert into users values ('', '$nom', '$uid', '$gid', '$home', '$shell', '$taille', '$fingerprint')"
    mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query3"


    if [ -d $home ]
    then
#	echo "taille du dossier : "
	taille=`du -s $home 2>/dev/null`
#	echo $taille
    fi
done
}
#main
database
