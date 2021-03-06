#!/bin/bash -e

# @see http://www.rethinkdb.com/docs/install/ubuntu/

# NOTE: Installing using these pre-packaged packages fails way too often
#       so we compile from source and ship our own binaries.

#sudo apt-get -y install software-properties-common debian-archive-keyring
#sudo add-apt-repository -y ppa:rethinkdb/ppa
# TODO: Only call update if repository above was not already added.
#sudo apt-get update
#sudo apt-get -y install rethinkdb


# In case above fails we can compile from source.
# Ubuntu 13.04
if [ -d "../../rethinkdb-1.13" ]; then
	echo "Using existign build from $(cd ../../rethinkdb-1.13; pwd)"
	cp -Rf ../../rethinkdb-1.13 rethinkdb
elif [ -d "../../../built/rethinkdb-1.13" ]; then
	echo "Using existign build from $(cd ../../../built/rethinkdb-1.13; pwd)"
	cp -Rf ../../../built/rethinkdb-1.13 rethinkdb
else
	sudo apt-get update
	sudo apt-get -y install git-core g++ nodejs npm libprotobuf-dev libgoogle-perftools-dev libncurses5-dev libboost-all-dev nodejs-legacy autogen pkg-config libcurl4-openssl-dev
	git clone --depth 1 -b v1.13.x https://github.com/rethinkdb/rethinkdb.git
	cd rethinkdb
	./configure --allow-fetch --fetch protobuf
	make
	cd ..
	cp -Rf rethinkdb ../../rethinkdb-1.13
fi

# HACK: Remove symlink that points to missing file which is preventing us from archiving this build.
#		error: Command failed: tar: build/rethinkdb/drivers/ruby/lib/ql2.pb.rb: File removed before we read it
rm rethinkdb/drivers/ruby/lib/ql2.pb.rb || true
