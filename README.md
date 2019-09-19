# CircleCI 2.0 build image based on CentOS with

 - JDK 8
 - Maven
 - Make
 - Node 10.6.3
 - Yarn 1.17.3
 - gcc
 - Chrome
 - gcc-c++

## Utilities

- Git
- Curl

## Working locally 

### Build the images
```
docker build -t reiniergs/centos7-jdk-node-browsers .
```

### Run images 
```
docker run -i -t reiniergs/centos7-jdk-node-browsers /bin/bash
```

### Push to docker hub
```
docker push reiniergs/centos7-jdk-node-browsers:latest
```


This image should work with CircleCI 2.0. This image could be find on [Docker Hub](https://hub.docker.com/r/reiniergs/centos7-jdk-node-browsers/) and freely used, but updates are not guaranteed ;-).
