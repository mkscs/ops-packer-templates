#!/bin/sh

# disable reverse DNS lookup for faster sshd logging
echo "UseDNS no" >> /etc/ssh/sshd_config

# get curl first
apt-get -y install curl

# add docker to repository
echo "deb https://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list
curl -sSL https://get.docker.io/gpg | apt-key add -

# update indexes
apt-get update -y

# install packages
apt-get -y install lxc-docker
apt-get -y install zsh

# some zsh makeup
cat <<'EOT' >> ~/.zshrc
autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
setopt auto_cd
setopt multios
setopt cdablevars
setopt prompt_subst

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
PROMPT='%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%} %{$fg[white]%}%Bon%b%{$reset_color%} %{$fg[yellow]%}%B%M%b%{$reset_color%} %(!..) '
RPROMPT='%(?,%F{green}%?,%F{red}%?)%f %{$fg[white]%} %*%{$reset_color%}'
EOT

# set default shell to zsh
chsh -s $(which zsh) vagrant
chsh -s $(which zsh) root

# disable release upgrade
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

# create a docker group and add an actual user

gpasswd -a ${USER} docker
gpasswd -a "vagrant" docker


sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
update-grub

