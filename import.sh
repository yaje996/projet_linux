#!/bin/sh

#grep /etc/passwd > /tmp/tpmfile

hote_db="localhost"
login_db="root"
nom_db="projet_linux"
nom_table="users"

import_system_users()
{
	query="SELECT nom,gid,gname,shell FROM users;"
	mysql -h "$hote_db" -u "$login_db" -D "$nom_db" -e "$query" | while read nom gid gname shell; do

    	echo "$nom:$gid:$gname:$shell"
	if [[ $(userExistinSys $nom) != "true" && "$nom" != "nom" ]]
	then
		if [[ $(groupExistinSys $gname) = "false" ]]
		then
			$(groupadd $gname)
		fi
		$(useradd -m -g "$gid" -G "$gname" -s "$shell" "$nom")
	fi
done
}

userExistinSys()
{
	for i in `cut -d: -f1 /etc/passwd`
	do
		echo $i>/tmp/tmpfile
		nom=$(cut -d: -f1 /tmp/tmpfile)

		if [[ "$1" = "$nom" ]]
		then
			echo "true"
		fi
	done

}

groupExistinSys()
{

   if grep -q $1 /etc/group
    then
         echo "true"
    else
         echo "false"
    fi

}

import_system_users
