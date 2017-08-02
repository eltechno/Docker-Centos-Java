#Docker file for java microservices bowpi - non-privileged user

FROM centos
MAINTAINER paulo.alvarado paulo@alvarado.com.gt

#copy the java startup script to etc, if you want to run any internal script
#COPY start.sh /etc/start.sh

ENV JAVA_VERSION 8u144
ENV BUILD_VERSION b01

# Upgrading system
RUN yum -y upgrade
RUN yum -y install wget

# Downloading Java
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$BUILD_VERSION/jdk-$JAVA_VERSION-linux-x64.rpm" -O /tmp/jdk-8-linux-x64.rpm

RUN yum -y install /tmp/jdk-8-linux-x64.rpm

RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest

#add the non-privileged user named USER, Replace user as needed 
RUN useradd -ms /bin/bash USER
USER user
