echo  -e '
export PATH=$PATH:/opt/bigdata/gradle-6.8/bin
'>> /etc/profile
AZKABAN_PATH=/opt/bigdata/azkaban-3.90.0
yum autoremove  java
yum install -y yum-utils java-1.8.0-openjdk* git

cd /opt/gradle
#wget https://github.com/azkaban/azkaban/archive/3.90.0.zip
#wget https://downloads.gradle-dn.com/distributions/gradle-6.8-bin.zip

unzip azkaban.zip
unzip gradle-6.8-bin.zip

cd azkaban-3.90.0
rm -rf build.gradle
mv ../build.gradle .