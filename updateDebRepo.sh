#!/bin/sh

# working directory
repodir=$1 

if [ -d $repodir ]

then

    cd ${repodir}
    # create the package index
    dpkg-scanpackages -m . > Packages
    cat Packages | gzip -9c > Packages.gz

    # create the Release file
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
else
    echo "Enter Valid Repo Path $1 path does not exist"
fi
