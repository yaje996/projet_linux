#!/bin/bash

#tail /var/log/messages > $1
cat /var/log/messages > /tmp/rapport.txt

egrep '/etc|passwd|aptitude|install|su|sudo|/etc/shadow|export|kill|userdel|wget|ssh|chgrp|chown|chmod|root|env|path|root|useradd|adduser|iptables' /tmp/rapport.txt > rapport

#if [ $# == 1 ]
#then
# egrep '/etc|passwd|aptitude|install|su|sudo|/etc/shadow|export|kill|userdel|wget|ssh|chgrp|chown|chmod|root|env|path|root|useradd|adduser|iptables' rapport.txt> tt

#    date=$(cut -d' ' -f1,2,3 $1)
 #   user=$(cut -d' ' -f5 $1 | cut -d'[' -f1)
  #  path=$(cut -d'[' -f5 $1 | cut -d']' -f1)
   # command=$(cut -d: -f4 $1)

#else
 #   echo "mettre en argument le fichier rapport"
#fi

