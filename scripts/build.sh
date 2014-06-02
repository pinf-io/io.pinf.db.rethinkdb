#!/bin/bash

# @see http://www.rethinkdb.com/docs/install/ubuntu/


#sudo add-apt-repository -y ppa:rethinkdb/ppa
#sudo apt-get update
#sudo apt-get -y install rethinkdb


# Ubuntu 13.04

sudo apt-get -y install git-core g++ nodejs npm libprotobuf-dev libgoogle-perftools-dev libncurses5-dev libboost-all-dev nodejs-legacy

git clone --depth 1 -b v1.12.x https://github.com/rethinkdb/rethinkdb.git

cd rethinkdb
./configure --allow-fetch
make
