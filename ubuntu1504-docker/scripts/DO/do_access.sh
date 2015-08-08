#!bin/sh

# create default user and home directory
useradd vagrant
mkdir /home/vagrant
cp /etc/skel* /home/vagrant
chown -R vagrant:vagrant /home/vagrant
echo "vagrant:vagrant" | chpasswd 

# grant vagrant's access
echo "Defaults:vagrant !requiretty" >> /etc/sudoers
echo "vagrant  ALL=(ALL) NOPASSWD:SETENV: /bin/" >> /etc/sudoers

