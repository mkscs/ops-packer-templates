# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
$share = ""

$ubuntu_ip = ''
$ubuntu_settings = <<SCRIPT
systemctl enable docker
systemctl start docker

apt-get install -y cachefilesd
cat <<EOF >> /etc/default/cachefilesd
RUN=yes
EOF

apt-get install -y puppet
systemctl stop puppet
unlink /etc/puppet/puppet.conf
ln -s /home/vagrant/projects/files/puppet.conf /etc/puppet/puppet.conf
puppet apply /home/vagrant/projects/puppet/manifests/init.pp
puppet cert revoke --all
puppet cert clean --all
rm -rf /var/lib/puppet/ssl/* 2>/dev/null
apt-get install -y puppetmaster
systemctl start puppet
puppet agent --enable
puppet agent -vt
puppet cert sign --all
SCRIPT

Vagrant.configure(2) do |config|

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder $share, "/home/vagrant/projects", type: "nfs",
    mount_options: ['rw', 'vers=3', 'tcp', 'fsc']

  config.vm.define "ubuntu", primary: true, autostart: false do |ubuntu|
    ubuntu.vm.box = "ubu1504-docker"
    
    ubuntu.vm.network :private_network, ip: $ubuntu_ip
    ubuntu.vm.provision "administrate_basic_vm_settings", type: "shell",
      inline: $ubuntu_settings
  end

  config.vm.define "coreos", autostart: false do |coreos|
    coreos.ssh.insert_key = false
    coreos.vm.box = "coreos-stable"
  end

end
