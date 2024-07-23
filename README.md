# Jellyfin-Deployment

### Deploy Jellyfin using Dockerfile
- Created an EC2 Instance.
- In the Security Group Rules allowed 8096 port for Jellyfin.
- Because, Jellyfin automatically run on port 8096.

![loading...](/images/Screenshot_20240723_095447.png)

- Then, Installed the Docker using official documentation.
- I used Ubuntu in EC2 instance. This is the official link to install docker in ubuntu machine https://docs.docker.com/engine/install/ubuntu/
- Further, created the folder media in EC2 instance and created subdirectory audio, video in media.
- Then, copy files from my local system to EC2 instance using **scp** command.
- After, created a dockerfile build jellyfin image and add files from EC2 instance to docker image.
- To run docker commands it needs to use sudo. If you want to allow non-priviledged users to run docker commands use following documentation https://docs.docker.com/engine/install/linux-postinstall/. 
- After, Created the image using following command.
```docker
sudo docker build -t myapp .
```
- 'docker build' is used to build a docker image from dockerfile. '-t' option is used to specify a name for the docker image is being built. Here, myapp is the name of the docker image. '.' tells the docker will look for the dockerfile in current directory.
- Then, check my image is created or not using following command.
```docker
sudo docker images
```
- After, created container using following command.
```docker
sudo docker run -d -p 8096:8096 myapp
```
- 'docker run' command is used to start and run a new container. '-d' option stands for detached mode. It runs the container in background. '-p' option is used to map ports between the host machine and the container. myapp is the docker image used to create container.
- Then, check the container is created or not using following command.
```docker
sudo docker ps
```

- After, I access the jellyfin using the ip address of my EC2 instance and the port number.
- http://ip_address:8096
- But, what's the problem here it is if you want to add new files you need to create new image and container again. That's the reason we can use build mounts in docker.
