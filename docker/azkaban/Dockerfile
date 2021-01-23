FROM centos:7
RUN mkdir /opt/gradle
COPY azkaban.zip /opt/gradle
COPY gradle-6.8-bin.zip /opt/gradle
RUN /opt/gradle/install.sh

# docker build -t azkaban .