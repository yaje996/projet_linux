#!/bin/sh

#grep /home/ /etc/passwd > /tmp/tpmfile

main()
{
for i in `cut -d: -f1,3,4,6,7 /tmp/tpmfile`
do
#    echo $i
    echo $i>/tmp/tmpfile
    nom=$(cut -d: -f1 /tmp/tmpfile)
    home=$(cut -d: -f4 /tmp/tmpfile)
    uid=$(cut -d: -f2 /tmp/tmpfile)
    gid=$(cut -d: -f3 /tmp/tmpfile)
    shell=`cut -d: -f5 /tmp/tmpfile`
    
    
    #echo $home
    echo $nom
    echo "\n"
    if [ -d $home ]
    then
#	echo "taille du dossier : "
	taille=`du -s $home 2>/dev/null`
#	echo $taille
    fi
done
}

database()
{
    for i in `cut -d: -f1,3,4,6,7 /tmp/tpmfile`
do
#    echo $i
    echo $i>/tmp/tmpfile
    nom=$(cut -d: -f1 /tmp/tmpfile)
    home=$(cut -d: -f4 /tmp/tmpfile)
    uid=$(cut -d: -f2 /tmp/tmpfile)
    gid=$(cut -d: -f3 /tmp/tmpfile)
    shell=`cut -d: -f5 /tmp/tmpfile`
    
    
    #echo $home
    echo $nom
    echo "\n"
    if [ -d $home ]
    then
#	echo "taille du dossier : "
	taille=`du -s $home 2>/dev/null`
#	echo $taille
    fi
done
    
    hote_db="localhost"
    login_db="root"
    nom_db="folder_hash"
    nom_table="folder"
    #query="use folder_hash; show tables;"
    query1="insert into users values ('', '$nom', '$uid', '$gid', '$home', '$shell', '$taille', '$fingerprint')"

    mysql -h "$hote_db" -D "$nom_db" -u "$login_db" -e "$query1"
}
#main
database
