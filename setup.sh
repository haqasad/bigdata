if [ -d _skip_ ] ; then
  git config --global user.name "generic"
  git config --global user.email "generic@nowhere.com"
  sudo apt-get -y update 
  sudo apt-get -y upgrade 
  sudo apt-get -y install default-jdk
  sudo apt-get -y install ssh
  sudo apt-get -y install rsync
  sudo apt-get -y install python-pip
  sudo apt-get -y install python2.7-dev
  pip install mrjob
fi

if [ ! -d /root/downloads ] ; then
  mkdir /root/downloads
fi

if [ ! -f /root/downloads/hadoop-2.6.0.tar.gz ] ; then
  pushd /root/downloads
  wget http://mirror.metrocast.net/apache/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
  popd
fi

if [ ! -d /root/hadoop ] ; then
  pushd /root/downloads
  tar -zxvf hadoop-2.6.0.tar.gz
  mv hadoop-2.6.0 /root/hadoop
  popd
fi

if [ ! -f /root/hadoop/streaming.jar ] ; then
wget http://repo.hortonworks.com/content/repositories/releases/org/apache/hadoop/hadoop-streaming/2.6.0.2.2.0.0-998/hadoop-streaming-2.6.0.2.2.0.0-998.jar
fi

cat >/root/hadoop/etc/hadoop/core-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
 <property>
      <name>hadoop.tmp.dir</name>
      <value>/tmp</value>
      <description>A base for other temporary directories.</description>
    </property>
</configuration>
EOF

cat >/root/hadoop/etc/hadoop/hdfs-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
 <property>
      <name>hadoop.tmp.dir</name>
      <value>/tmp</value>
      <description>A base for other temporary directories.</description>
    </property>
</configuration>
EOF

cat >/root/hadoop/etc/hadoop/mapred-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property> 
    <name>mapreduce.framework.name</name> 
    <value>yarn</value> 
  </property>
</configuration>
EOF

cat >/root/hadoop/etc/hadoop/yarn-site.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>

    <!-- Site specific YARN configuration properties -->
    <property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>128</value>
        <description>Minimum limit of memory to allocate to each container request at the Resource Manager.</description>
    </property>
    <property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>2048</value>
        <description>Maximum limit of memory to allocate to each container request at the Resource Manager.</description>
    </property>
    <property>
        <name>yarn.scheduler.minimum-allocation-vcores</name>
        <value>1</value>
        <description>The minimum allocation for every container request at the RM, in terms of virtual CPU cores. Requests lower than this won't take effect, and the specified value will get allocated the minimum.</description>
    </property>
    <property>
        <name>yarn.scheduler.maximum-allocation-vcores</name>
        <value>2</value>
        <description>The maximum allocation for every container request at the RM, in terms of virtual CPU cores. Requests higher than this won't take effect, and will get capped to this value.</description>
    </property>
    <property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>4096</value>
        <description>Physical memory, in MB, to be made available to running containers</description>
    </property>
    <property>
        <name>yarn.nodemanager.resource.cpu-vcores</name>
        <value>4</value>
        <description>Number of CPU cores that can be allocated for containers.</description>
    </property>

    <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
      <description>shuffle service that needs to be set for Map Reduce to run </description>
    </property>
</configuration>
EOF


if [ ! -f  ~/.ssh/id_dsa ] ; then
  ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
  cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
fi

export JAVA_HOME=/usr/lib/jvm/default-java
export HADOOP_HOME=/root/hadoop
export PATH=$HADOOP_HOME/bin:$PATH
echo export JAVA_HOME=/usr/lib/jvm/default-java >>~/.bashrc
echo export HADOOP_HOME=/root/hadoop >>~/.bashrc
echo export PATH=$HADOOP_HOME/bin:$PATH >>~/.bashrc

