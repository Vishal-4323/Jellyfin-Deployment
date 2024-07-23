# Jellyfin-Deployment

### Jellyfin

- Jellyfin is a free and open-source media server software that allows users to manage and stream their media collections.
- Users can stream their media content to various devices, such as smartphones, tablets, smart TVs, and web browsers. It supports multiple apps for playback across different platforms.

### Deploy Jellyfin using Dockerfile

- Created an EC2 Instance.
- In the Security Group Rules allowed 8096 port for Jellyfin.
- Because, Jellyfin automatically run on port 8096.

![loading...](/images/Screenshot_20240723_095447.png)

- Then, Installed the Docker using official documentation.
- I used Ubuntu in EC2 instance. This is the official link to install docker in ubuntu machine https://docs.docker.com/engine/install/ubuntu/
- Next, created the folder media in EC2 instance and created subdirectory audio, video in media.
- Afterward, copy files from my local system to EC2 instance using **scp** command.
- In the next step, created a dockerfile build jellyfin image and add files from EC2 instance to docker image.
- To run docker commands it needs to use sudo. If you want to allow non-priviledged users to run docker commands use following documentation https://docs.docker.com/engine/install/linux-postinstall/. 
- After, Created the image by executing the command.
```docker
sudo docker build -t myapp .
```
- **docker build** is used to build a docker image from dockerfile. **-t** option is used to specify a name for the docker image is being built. Here, myapp is the name of the docker image. **.** tells the docker will look for the dockerfile in current directory.
- Then, check my image is created or not using following command.
```docker
sudo docker images
```
- Next, created container with the command.
```docker
sudo docker run -d -p 8096:8096 myapp
```
- **docker run** command is used to start and run a new container. **-d** option stands for detached mode. It runs the container in background. **-p** option is used to map ports between the host machine and the container. myapp is the docker image used to create container.
- Afterward, check the container is created or not by running the command.
```docker
sudo docker ps
```

- Furthermore, I access the jellyfin using the ip address of my EC2 instance and the port number.
- http://ip_address:8096
- But, what's the problem here it is if you want to add new files you need to create new image and container again. That's the reason we can use bind mounts in docker.

### Deploy Jellyfin using Bind mounts

- Did the same steps upto the creating dockerfile.
- Thereafter, download the latest jellyfin container image.
```docker
sudo docker pull jellyfin/jellyfin
```
- Next, executing the following command to create a container with bind mount.
```docker
sudo docker run -d -p 8096:8096 --mount type=bind,source=/home/ubuntu/media,target=/home jellyfin/jellyfin
```
- **mount** option is used to mount a directory from the host into the container. This is used for sharing files between the host and the container. **type=bind** specifies we used bind mount which means a file directory from the host file system will be mounted into the container. **source=/home/ubuntu/media** this is the path on the host we mount. **target=/home** this is the path inside the container where the host directory will be mount. 
- In this case, contents of **/home/ubuntu/media** on the host will be accessible **/home** inside the container.
- So, when I creating libraries in the Jellyfin I give the **/home** path to the library. In this way, I can get files from my host machine without create new image.