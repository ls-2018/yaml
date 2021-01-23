yum install wget -y
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all     # 清除系统所有的yum缓存
yum makecache  # 生成yum缓存
yum install -y net-tools htop gcc* python3-pip unzip vimwq

source /etc/profile

#./gradlew clean
./gradlew build installDist -x test
# disable ipv6
sysctl net.ipv6.conf.all.disable_ipv6=1

. mysql.sh

AZKABAN_PATH=/opt/bigdata/azkaban-3.90.0

cd ..
mkdir xxxxxxxxxx
mkdir AZKABAN_PATH
mkdir AZKABAN_PATH
mv xxxxxxxxxx/azkaban-hadoop-security-plugin/build/install/azkaban-hadoop-security-plugin $AZKABAN_PATH
mv xxxxxxxxxx/az-hadoop-jobtype-plugin/build/install/az-hadoop-jobtype-plugin $AZKABAN_PATH
mv xxxxxxxxxx/azkaban-exec-server/build/install/azkaban-exec-server $AZKABAN_PATH
mv xxxxxxxxxx/azkaban-solo-server/build/install/azkaban-solo-server $AZKABAN_PATH
mv xxxxxxxxxx/azkaban-web-server/build/install/azkaban-web-server $AZKABAN_PATH
mv xxxxxxxxxx/az-hdfs-viewer/build/install/az-hdfs-viewer $AZKABAN_PATH
mv xxxxxxxxxx/az-jobsummary/build/install/az-jobsummary $AZKABAN_PATH
mv xxxxxxxxxx/az-reportal/build/install/az-reportal $AZKABAN_PATH
mv xxxxxxxxxx/azkaban-db/build/install/azkaban-db $AZKABAN_PATH
mv xxxxxxxxxx/az-crypto/build/install/az-crypto $AZKABAN_PATH
rm -rf xxxxxxxxxx


# replace config
rm -rf $AZKABAN_PATH/azkaban-solo-server/conf/azkaban.properties
mv ./conf/solo.properties $AZKABAN_PATH/azkaban-solo-server/conf -y
rm -rf $AZKABAN_PATH/azkaban-exec-server/conf/azkaban.properties
mv ./conf/exec.properties $AZKABAN_PATH/azkaban-exec-server/conf -y


cd $AZKABAN_PATH/azkaban-solo-server
./bin/start-solo.sh

cd $AZKABAN_PATH/azkaban-exec-server
./bin/start-exec.sh

curl -G "localhost:$(<./executor.port)/executor?action=activate" && echo