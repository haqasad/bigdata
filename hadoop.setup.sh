cd $HOME
if [ ! -f .updated_apt_get ] ; then
  echo "Setting up system software"
  sudo apt-get -y update 
  sudo apt-get -y upgrade 
  sudo apt-get -y clean
  sudo apt-get -y install git
  sudo apt-get -y install default-jdk
  sudo apt-get -y install ssh
  sudo apt-get -y install rsync
  sudo apt-get -y install ntp
  sudo apt-get -y install python-pip
  sudo apt-get -y install python2.7-dev
  sudo apt-get -y install libyaml-dev
  sudo apt-get -y install openjdk-7-jdk
  sudo pip install mrjob
  git config --global user.name "$USER"
  git config --global user.email "$USER@example.com"
  export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
  echo "export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >>./.bashrc
  touch .updated_apt_get
fi

cd $HOME
if [ ! -d $HOME/.downloads ] ; then
  echo "Creating download directory..."
  mkdir $HOME/.downloads
fi

cd $HOME
if [ ! -f $HOME/.downloads/hadoop-1.2.1.tar.gz ] ; then
  echo "Downloading hadoop files..."
  cd $HOME/.downloads
  wget http://mirror.reverse.net/pub/apache/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz
  tar xvf hadoop-1.2.1.tar.gz
fi

cd $HOME
if [ ! -d /usr/local/hadoop ] ; then
  echo "Installing hadoop files..."
  sudo mv hadoop-1.2.1 /usr/local/hadoop
  cd $HOME
  export HADOOP_PREFIX=/usr/local/hadoop
  export PATH=$PATH:$HADOOP_PREFIX/bin
  echo "export HADOOP_PREFIX=/usr/local/hadoop" >>$HOME/.bashrc
  echo "export PATH=$PATH:$HADOOP_PREFIX/bin" >>$HOME/.bashrc
fi

cd $HOME
if [ ! -f $HOME/.updated_ssh_key ] ; then
  echo "Setting up SSH keys..."
  ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa
  cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
  ssh-keyscan localhost >> $HOME/.ssh/known_hosts
  touch $HOME/.updated_ssh_key
fi

