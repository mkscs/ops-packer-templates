Packer templates for various systems and providers

**Prereq:** Packer.io has to be installed

Virtualbox
- Ubuntu (15.04-docker)
- CoreOS
- RancherOS

DigitalOcean
- Ubuntu (15.04-docker)

**Ubuntu 15.04 - docker**
  - currently builds upstart box by default
* DO uses **vagrant:vagrant** credentials 
* vbox uses mitchellh's pub key & **vagrant:vagrant**
* installs docker by default

**CoreOS**
* vbox uses mitchellh's pub key & **vagrant:vagrant**
* Vagrantfile setting prevents vagrant from inserting a newly generated key. Provision the box with a custom key or change the key later on manually. Vagrant pushes a new key by inserting an "authorized_keys" file but coreos uses a slightly different mechanism.
- **issues**
  - NFS & private networking are not working with vagrant yet -> https://github.com/mitchellh/vagrant/issues/6608

**RancherOS**
* vbox uses mitchellh's pub key
* contains default certificates for docker tls. **passphrase:vagrant**
* use client certs to authenticate or overwrite cloud-config and generate your own
* builds in headless mode by default




