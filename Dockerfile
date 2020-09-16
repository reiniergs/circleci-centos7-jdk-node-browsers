
FROM		centos:7
LABEL maintaner.name="Reinier Guerra" 
LABEL maintaner.email="reiniergs@gmail.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum -y update
RUN yum install -y git tar curl wget sudo make yum-utils device-mapper-persistent-data lvm2 java-1.8.0-openjdk-headless java-1.8.0-openjdk-devel maven && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum clean all

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install chrome and chromedriver
RUN yum install -y xorg-x11-server-Xvfb unzip zip

WORKDIR /usr/tmp
ADD google-chrome-stable_current_83.0.4103.116_x86_64.rpm /tmp
RUN yum install -y /tmp/google-chrome-stable_current_83.0.4103.116_x86_64.rpm \
    && rm /tmp/google-chrome-stable_current_83.0.4103.116_x86_64.rpm

# Chromedriver
RUN mkdir -p /root/tmp/chromedriver/83
ADD chromedriver_83.0.4103.39_linux64.zip /root/tmp/chromedriver/83/
RUN unzip /root/tmp/chromedriver/83/chromedriver_83.0.4103.39_linux64.zip -d /bin
RUN chmod -R 0755 /bin/chromedriver
ENV PATH /bin/chromedriver:$PATH

# Hub (GitHub CLI Wrapper)
RUN mkdir -p /root/tmp/hub
ADD hub-linux-amd64-2.12.7.tgz /root/tmp/hub/
RUN cp /root/tmp/hub/hub-linux-amd64-2.12.7/bin/hub /bin
RUN chmod -R 0755 /bin/hub
ENV PATH /bin/hub:$PATH

RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Install CFSSL
RUN curl -o /usr/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
RUN curl -o /usr/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64

# Install Node
RUN curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
RUN yum install -y nodejs
RUN node -v
RUN npm -v

# Install Yarn
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
RUN yum install -y yarn
RUN yum -y install gcc
RUN yum -y install gcc-c++

USER circleci
