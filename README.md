# CircleCI 2.0 build image based on CentOS with

 - JDK 8
 - Maven
 - Make
 - Node 8
 - Yarn
 - gcc
 - Chrome

## Utilities

- Git
- Curl

## Working locally 

### Build the images
```
docker build -t reiniergs/centos7-jdk-node8-browsers .
```

### Run images 
```
docker run -i -t reiniergs/centos7-jdk-node8-browsers /bin/bash
```

### Push to docker hub
```
docker push reiniergs/centos7-jdk-node8-browsers:latest
```


This image should work with CircleCI 2.0. This image could be find on [Docker Hub](https://hub.docker.com/r/reiniergs/centos7-jdk-node8-browsers/) and freely used, but updates are not guaranteed ;-).
