#!/bin/sh

grep /home/ /etc/passwd > /tmp/tpmfile

hote_db="localhost"
login_db="root"
nom_db="projet_linux"
nom_table="users"

HOST=raphaeldulong.com
USER=raphael
PASS=esgi2018

insert_system_users()
{
    query1="CREATE DATABASE IF NOT EXISTS projet_linux;"
    query2="CREATE TABLE IF NOT EXISTS users (
                uid INT(10) PRIMARY KEY,
                nom VARCHAR(30),
                gid VARCHAR(50),
		gname VARCHAR(50),
                home VARCHAR(30),
                shell VARCHAR(30),
                taille VARCHAR(50),
                first_fingerprint VARCHAR(50));"

    #A utiliser pour supprimer la table:
    queryDELETE="DROP TABLE users;"
    mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$queryDELETE"
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
    
    #Fingerprint du repertoire home
    if [ -d $home ]
    then
	taille=$(du -s $home 2>/dev/null)
        fingerprint=$(tar c $home | md5sum)
    fi
    
    #Recherche du groupe name
    for i in `cut -d: -f1,3 /etc/group`
    do
	groupename=$(cut -d: -f1 /tmp/tmpfile)
	groupeid=$(cut -d: -f3 /tmp/tmpfile)
	if [[ "$gid" = "$groupeid" ]]
	then
		gname=$groupename
	fi
    done

    if [[ -z "$(userExistinDB $uid)" ]]
    then
        query3="insert into users values ('$uid', '$nom', '$gid','$gname', '$home', '$shell', '$taille', '$first_fingerprint')"
	mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query3"
    fi
#: '
echo $home
zip -r $nom.zip $home
#export du home zipé sur ftp
echo "
open raphaeldulong.com
user $USER $PASS
binary
put $nom.zip
bye
"| ftp -n > ftp_$$.log

#rm $nom.zip
#'
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
