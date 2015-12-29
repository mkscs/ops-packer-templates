#!/bin/sh
version="2.2.4"
curl -o /tmp/ruby-"$version" https://cache.ruby-lang.org/pub/ruby/2.2/ruby-"$version".tar.gz
cd /tmp
tar -xvf ruby-"$version"
cd ruby-"$version"/
./configure
make
make install
if [ "$?" == 0 ];then
	echo "Ruby $version installed"
	cd /
	rm -rf /tmp/ruby-"$version"
fi