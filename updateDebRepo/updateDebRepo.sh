#!/bin/sh
repodir=$1 

if [ -d $repodir ]
then
    inotifywait -rme modify,move,close_write,create,delete,delete_self $repodir |  while read dir action file
    do 
        if [ "${file##*.}" == "deb" ]
        then 
            rm -rf $dir/Packages.gz ;  
            dpkg-scanpackages -m $dir > Packages
            cat $dir/Packages | gzip -9c > $dir/Packages.gz
            PKGS=$(wc -c Packages)
            PKGS_GZ=$(wc -c Packages.gz)
            cat <<EOF > Release
            Architectures: all
            Date: \$(date -R)
            MD5Sum:
            $(md5sum Packages  | cut -d" " -f1) $PKGS
            $(md5sum Packages.gz  | cut -d" " -f1) $PKGS_GZ
            SHA1:
            $(sha1sum Packages  | cut -d" " -f1) $PKGS
            $(sha1sum Packages.gz  | cut -d" " -f1) $PKGS_GZ
            SHA256:
            $(sha256sum Packages | cut -d" " -f1) $PKGS
            $(sha256sum Packages.gz | cut -d" " -f1) $PKGS_GZ
EOF
        fi 
    done
else
    echo "Enter Valid Repo Path $1 path does not exist"
fi









