HOST = "raphaeldulong.com"
USER = "raphael"
PASSWD = "esgi2018"
grep /home/ /etc/passwd > /tmp/tpmfile

test()
{
 
   for i in `cut -d: -f1,3,4,6,7 /tmp/tpmfile`
do
    echo $i>/tmp/tmpfile
    nom=$(cut -d: -f1 /tmp/tmpfile)
    home=$(cut -d: -f4 /tmp/tmpfile)
    uid=$(cut -d: -f2 /tmp/tmpfile)
    gid=$(cut -d: -f3 /tmp/tmpfile)
    shell=`cut -d: -f5 /tmp/tmpfile`


echo $home
zip -r $nom.zip $home

ftp -n $HOST <<END_SCRIPT
quote USER $USER
quote PASS $PASSWD
binary
put $nom.zip
quit
END_SCRIPT
exit 0

rm $nom.zip
done
}

test
