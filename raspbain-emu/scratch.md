sudo apt install binfmt-support qemu qemu-user-static debootstrap  schroot

sudo qemu-debootstrap --arch=arm64 xenial arm64-ubuntu

sudo qemu-debootstrap --arch=armel jessie armel-jessie

qemu-debootstrap --arch=x86_64 jessie x86_64-jessie

qemu-debootstrap --arch=amd64 jessie x86_64-jessie

qemu-debootstrap --arch=amd64 jessie amd64-jessie


sudo mount -i -o remount,exec,dev arm64-ubuntu


wget http://archive.raspbian.org/raspbian.public.key -O - | sudo apt-key add -q

qemu-debootstrap --keyring=/etc/apt/trusted.gpg --arch armhf stretch armf-raspbain-stretch http://mirrordirector.raspbian.org/raspbian/

debootstrap --keyring=raspbian.public.key --arch=amd64 stretch jessie http://mirrordirector.raspbian.org/raspbian/

wget https://archive.raspbian.org/raspbian.public.key -O /usr/share/keyrings/raspbian.public.key

qemu-debootstrap --keyring=/usr/share/keyrings/raspbian.public.key --arch armhf stretch armf-raspbain-stretch http://mirrordirector.raspbian.org/raspbian/

echo "[armel-jessie]
description=armel-jessie(armel)
directory=$(pwd)/armel-jessie
root-users=$(whoami)
users=$(whoami)
type=directory" |  tee /etc/schroot/chroot.d/armel-jessie

echo "[x86_64-jessie]
description=x86_64-jessie(armel)
directory=$(pwd)/x86_64-jessie
root-users=$(whoami)
users=$(whoami)
type=directory" |  tee /etc/schroot/chroot.d/x86_64-jessie


echo "[amd64-jessie]
description=amd64-jessie(armel)
directory=$(pwd)/amd64-jessie
root-users=root
users=root
type=directory" |  tee /etc/schroot/chroot.d/x86_64-jessie



cat > ./etc/fstab <<EOF
proc            /proc           proc    defaults          0       0
/dev/mmcblk0p1  /boot           vfat    defaults          0       2
/dev/mmcblk0p2  /               ext4    defaults,noatime  0       1
EOF


docker run --rm -t arm32v6/alpine uname -m

docker build --rm -t my-arm32v6-alpine -<<EOF
FROM multiarch/qemu-user-static:arm as qemu
FROM arm32v6/alpine
COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin
EOF


docker build --rm -t my-arm32v7-debain-jessie -<<EOF
FROM multiarch/qemu-user-static:arm as qemu
FROM arm32v7/debain:jessie
COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin
EOF



docker run --rm -t raspbain-jessie-lite-qemu-arm32-2017-02-27:latest		 uname -m
FROM multiarch/qemu-user-static:arm as qemu
FROM scratch
ADD raspbian_lite_2017-02-27-1526_root.tar.xz  /
COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin
CMD ["bash"]

raspbain-jessie-lite-qemu-arm32-2017-02-27:latest
docker run \
  -p 8080:8080 \
  -v /home/indec40/guacamole:/config \
  oznu/guacamole


sudo docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=9090:8080 \
  --detach=true \
  --name=cadvisor \
  --privileged \
  --device=/dev/kmsg \
  gcr.io/google-containers/cadvisor:latest


  C:\Users\L04A6265078\AppData\Local\Google\Chrome\Application\chrome.exe --ignore-certificate-errors  --user-data-dir=~/chrometemp


docker run --name guacd -d guacamole/guacd
  docker run --name postgres-4-guacamole -e POSTGRES_PASSWORD=postgres -d postgres

su postgres

psql 

create database guacamole_db;
create user guacamole_user with encrypted password 'guacamole_password';
grant all privileges on database guacamole_db to guacamole_user;

  docker run --name guacamole --link guacd:guacd \
    --link   postgres-4-guacamole:postgres      \
    -e POSTGRES_DATABASE=guacamole_db  \
    -e POSTGRES_USER=guacamole_user    \
    -e POSTGRES_PASSWORD=guacamole_password \
    -d -p 8080:8080 guacamole/guacamole:latest



docker run --name guacamole-standalone \
    --link   postgres-4-guacamole:postgres      \
    -e GUACD_HOSTNAME=10.87.61.84 \
    -e GUACD_PORT=4822 \
    -e POSTGRES_DATABASE=guacamole_db  \
    -e POSTGRES_USER=guacamole_user    \
    -e POSTGRES_PASSWORD=guacamole_password \
    -d -p 8080:8080 guacamole/guacamole:latest
