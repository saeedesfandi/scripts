$ sudo apt-get update
$ sudo apt-get install default-jdk
$ java -version
$ sudo apt-get install ssh
$ sudo apt-get install rsync
$ ssh-keygen
$ ssh-copy-id saeed@localhost
$ wget -c http://www.us.apache.org/dist/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz
$ sudo tar -zxf hadoop-2.*.tar.gz
$ sudo mv hadoop-2.7.1 /usr/local/hadoop
$ update-alternatives --config java
$ sudo gedit ~/.bashrc

          #Hadoop Variables
          export JAVA_HOME=/usr/java/default
          export HADOOP_HOME=/usr/local/hadoop
          export PATH=$PATH:$HADOOP_HOME/bin
          export PATH=$PATH:$HADOOP_HOME/sbin
          export HADOOP_MAPRED_HOME=$HADOOP_HOME
          export HADOOP_COMMON_HOME=$HADOOP_HOME
          export HADOOP_HDFS_HOME=$HADOOP_HOME
          export YARN_HOME=$HADOOP_HOME
          export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
          export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

$ source ~/.bashrc
$ cd /usr/local/hadoop/etc/hadoop
$ sudo gedit hadoop-env.sh
          #The java implementation to use.
          export JAVA_HOME="/usr/java/default"
$ sudo gedit core-site.xml
          <configuration>
                  <property>
                      <name>fs.defaultFS</name>
                      <value>hdfs://localhost:9000</value>
                  </property>
          </configuration>
$ sudo gedit yarn-site.xml
          <configuration>
                  <property>
                      <name>yarn.nodemanager.aux-services</name>
                      <value>mapreduce_shuffle</value>
                  </property>
                  <property>
                      <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
                      <value>org.apache.hadoop.mapred.ShuffleHandler</value>
                  </property>
          </configuration>
$ sudo cp mapred-site.xml.template mapred-site.xml
$ sudo gedit mapred-site.xml
          <configuration>
                  <property>
                      <name>mapreduce.framework.name</name>
                      <value>yarn</value>
                  </property>
          </configuration>
$ sudo gedit hdfs-site.xml
          <configuration>
                  <property>
                      <name>dfs.replication</name>
                      <value>1</value>
                  </property>
                  <property>
                      <name>dfs.namenode.name.dir</name>
                      <value>file:/srv/hdfs/name</value>
                  </property>
                  <property>
                      <name>dfs.datanode.data.dir</name>
                      <value>file:/srv/hdfs/data</value>
                  </property>
          </configuration>
$ cd
$ mkdir -p /srv/hdfs/name
$ mkdir -p /srv/hdfs/data
$ sudo chown saeed:saeed -R /usr/local/hadoop
$ hdfs namenode -format
$ start-all.sh
$ jps

firewall-cmd --zone=public --add-port=8088/tcp 
firewall-cmd --zone=public --add-port=50070/tcp 
firewall-cmd --zone=public --add-port=50090/tcp 
firewall-cmd --zone=public --add-port=50075/tcp 

http://localhost:8088/
http://localhost:50070/
http://localhost:50090/
http://localhost:50075/
192.168.26.128
http://lidaco.ir:8088
http://lidaco.ir:50070
http://lidaco.ir:50090
http://lidaco.ir:50075


Namenode > hadoopmnmaster > 192.168.255.129

Datanodes >  hadoopmnslave1 > 192.168.255.130
                      hadoopmnslave2 > 192.168.255.131
                      hadoopmnslave3 > 192.168.255.132

Clone Hadoop Single node cluster as hadoopmaster

Hadoopmaster Node
$ sudo gedit /etc/hosts
                      hadoopmnmaster   192.168.255.129
                      hadoopmnslave1   192.168.255.130
                      hadoopmnslave2   192.168.255.131
                      hadoopmnslave3   192.168.255.132
$ sudo gedit /etc/hostname
                      hadoopmnmaster
$ cd /usr/local/hadoop/etc/hadoop
$ sudo gedit core-site.xml
                       replace localhost as hadoopmnmaster
$ sudo gedit hdfs-site.xml
                       replace value 1 as 3 (represents no of datanode)
$ sudo gedit yarn-site.xml
                       add the following configuration
                       <configuration>
                              <property>
                                  <name>yarn.resourcemanager.resource-tracker.address</name>
                                  <value>hadoopmnmaster:8025</value>
                       <property>
                       <property>
                                  <name>yarn.resourcemanager.scheduler.address</name>
                                  <value>hadoopmnmaster:8030</value>
                       <property>
                       <property>
                                  <name>yarn.resourcemanager.address</name>
                                  <value>hadoopmnmaster:8050</value>
                             </property>
                       </configuration>
$ sudo gedit mapred-site.xml
                       replace mapreduce.framework.name as mapred.job.tracker
                       replace yarn as hadoopmnmaster:54311
$ sudo gedit /usr/local/hadoop/etc/hadoop/hdfs-site.xml
                       remove dfs.namenode.name.dir property section
$ sudo rm -rf /usr/local/hadoop/hadoop_data
$ sudo mkdir -p /usr/local/hadoop/hadoop_data/hdfs/datanode
$ sudo chown -R chaal:chaal /usr/local/hadoop

Reboot hadoopmaster node

Clone Hadoopmaster Node as hadoopslave1, hadoopslave2, hadoopslave3

Hadoopslave Node (conf should be done on each slavenode)

$ sudo gedit /etc/hostname

                      hadoopmnslave

reboot all nodes
Hadoopmaster Node
$ sudo gedit /usr/local/hadoop/etc/hadoop/masters
                       hadoopmnmaster
$ sudo gedit /usr/local/hadoop/etc/hadoop/slaves

                       remove localhost and add 

                       hadoopmnslave1
                       hadoopmnslave2
                       hadoopmnslave3

$ sudo gedit /usr/local/hadoop/etc/hadoop/hdfs-site.xml

                       replace dfs.datanode.data.dir property section

                       as dfs.namenode.name.dir 

          $ sudo rm -rf /usr/local/hadoop/hadoop_data
          $ sudo mkdir -p /usr/local/hadoop/hadoop_data/hdfs/namenode
          $ sudo chown -R chaal:chaal /usr/local/hadoop
          $ sudo ssh-copy-id -i ~/.ssh/id_dsa.pub chaal@hadoopmnmaster
          $ sudo ssh-copy-id -i ~/.ssh/id_dsa.pub chaal@hadoopmnslave1
          $ sudo ssh-copy-id -i ~/.ssh/id_dsa.pub chaal@hadoopmnslave2
          $ sudo ssh-copy-id -i ~/.ssh/id_dsa.pub chaal@hadoopmnslave3
          $ sudo ssh hadoopmnmaster
          $ exit
          $ sudo ssh hadoopmnslave1
          $ exit
          $ sudo ssh hadoopmnslave2
          $ exit
          $ sudo ssh hadoopmnslave3
          $ exit
          $ hadoop namenode -format
          $ start-all.sh
          $ jps (check in all 3 datanodes)


http://hadoopmnmaster:8088/
http://hadoopmnmaster:50070/
http://hadoopmnmaster:50090/

http://hadoopmnmaster:50075/