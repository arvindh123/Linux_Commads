
# How Run Raspbain OS Jessie in CentOS machine with docker 

## Step 1
Install Docker ;-)


## Step 2 
sudo apt install binfmt-support qemu qemu-user-static debootstrap  schroot (This was needed or not need to validate)


## Step 3

docker run --rm --privileged multiarch/qemu-user-static --reset 


## Step 4 
Donwload the raspbain jessie form the following link
I have downloaded the  raspbain jessie lite 2017-02-27-15:26 and rename to raspbian_lite_2017-02-27-1526_root.tar.xz
```
wget http://downloads.raspberrypi.org/raspbian_lite/archive/2017-02-27-15:26/root.tar.xz
mv  root.tar.xz raspbian_lite_2017-02-27-1526_root.tar.xz
```

## Step 4 
Create Dokcer File

```
nano dockerfile 
```
Add the following lines
```
FROM multiarch/qemu-user-static:arm as qemu
FROM scratch
ADD raspbian_lite_2017-02-27-1526_root.tar.xz  /
COPY --from=qemu /usr/bin/qemu-arm-static /usr/bin
CMD ["bash"]
```

## Step 5 
Create the docker image
```
docker build --tag raspbain-jessie-lite-qemu-arm32-2017-02-27 .
```

## Step 6 
Run the Image :-) 

```
docker run --rm -t raspbain-jessie-lite-qemu-arm32-2017-02-27:latest		 uname -m
```

**Output** 
```
armv7l
```