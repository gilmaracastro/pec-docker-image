FROM lissonpsantos2/debian-jessie-basic:latest

MAINTAINER Alisson Pereira dos Santos <lissonpsantos2@gmail.com>

#IMAGE VARIABLES
ENV PEC_FOLDER /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh
ENV IMAGE_ALIAS ESUS 3.0.08
ENV SEPARATOR -
ENV INFO_IMAGE "To start the PEC3.0 run: sh ${PEC_FOLDER} start"

#CREATE PEC 3.0 FOLDER
RUN mkdir /home/PEC

#SET WORKDIR PEC 3.0 FOLDER
WORKDIR /home/PEC

#UPDATE IMAGE
RUN apt-get update
RUN apt-get upgrade -y

#INSTALL PACKAGES
RUN apt-get install -y openjdk-7-jdk

#PEC INSTALL

RUN wget http://189.28.128.100/dab/docs/portaldab/aplicativos/Instalador-eSUS-AB-PEC-3_0_08-Treinamento_Linux__12072018.zip
RUN unzip Instalador-eSUS-AB-PEC-3_0_08-Treinamento_Linux__12072018.zip -d /home/PEC/install
WORKDIR /home/PEC/install

#LOCALE PT_BR
RUN rm /etc/locale.gen
ADD locale /etc/locale.gen

#JAVA.CONF FILE
RUN rm /etc/java.conf
ADD javaconf /etc/java.conf

RUN apt-get install -y locales
RUN locale-gen
RUN sh instalador_linux.sh

WORKDIR /