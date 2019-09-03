
FROM		centos:7
LABEL maintaner.name="Reinier Guerra" 
LABEL maintaner.email="reiniergs@gmail.com"

# Install needed software and users
USER root
RUN groupadd -r circleci && useradd -r -d /home/circleci -m -g circleci circleci
RUN yum install -y git tar curl wget sudo make yum-utils device-mapper-persistent-data lvm2 java-1.8.0-openjdk-headless java-1.8.0-openjdk-devel maven && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum install -y docker-ce && \
    yum clean all

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install chrome and chromedriver
RUN yum install -y xorg-x11-server-Xvfb unzip zip

WORKDIR /usr/tmp
ADD google-chrome-stable-65.0.3325.181-1.x86_64.rpm /tmp
RUN yum install -y /tmp/google-chrome-stable-65.0.3325.181-1.x86_64.rpm \
    && rm /tmp/google-chrome-stable-65.0.3325.181-1.x86_64.rpm

# Chromedriver
RUN mkdir -p /root/tmp/chromedriver/2.37
ADD chromedriver-2.37-linux64.zip /root/tmp/chromedriver/2.37/
RUN unzip /root/tmp/chromedriver/2.37/chromedriver-2.37-linux64.zip -d /bin
RUN chmod -R 0755 /bin/chromedriver
ENV PATH /bin/chromedriver:$PATH

RUN echo "%circleci        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

# Install CFSSL
RUN curl -o /usr/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
RUN curl -o /usr/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64

# Install Node
RUN curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
RUN yum install -y nodejs
RUN node -v
RUN npm -v

# Install Yarn
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
RUN yum install -y yarn
RUN yum -y install gcc

USER circleci
