
# How Run Raspbain OS Jessie in CentOS machine with docker 

## Step 1
Install Docker ;-)


## Step 2 
Install the requirements (This was needed or not need to validate)
```
sudo apt install binfmt-support qemu qemu-user-static debootstrap  schroot
```



## Step 3
Run the below docker command 
```
 docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
```

If are getting failed the your are running centos with kernal of older run , to overcome these run  below 
```
docker run --rm --privileged multiarch/qemu-user-static --reset 
```

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

If you followed this command  ``` docker run --rm --privileged multiarch/qemu-user-static --reset -p yes ```  and got successfull installtion  qemu-user-static without any error , then add the following lines in dockerfile
```
FROM scratch
ADD raspbian_lite_2017-02-27-1526_root.tar.xz  /
CMD ["bash"]
```

If you got failed in STEP 3  and installed qemu-user-static with following command  ``` docker run --rm --privileged multiarch/qemu-user-static --reset  ``` , then add the  following lines in dockerfile 

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

## If Any this is mentioned wrong feel free to edit it.
