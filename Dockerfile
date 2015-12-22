FROM node:latest
MAINTAINER Jan Blaha
EXPOSE 2945

RUN apt-get update && apt-get install -y sudo
RUN adduser --disabled-password --gecos "" jsreport
RUN echo "jsreport ALL=(root) NOPASSWD: /usr/local/bin/node" >> /etc/sudoers
RUN echo "jsreport ALL=(root) NOPASSWD: /usr/local/bin/npm" >> /etc/sudoers

VOLUME ["/jsreport"]

WORKDIR /home/jsreport

RUN sudo npm install jsreport

# WORKDIR /home/jsreport/node_modules/jsreport
# RUN npm install
# RUN npm install -g grunt-cli
# RUN grunt

ADD run.sh /home/jsreport/run.sh

WORKDIR /home/jsreport
RUN sudo node node_modules/jsreport --init
CMD ["bash", "/home/jsreport/run.sh"]
