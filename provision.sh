#!/usr/bin/env bash

sudo su

if [ ! -d "/var/www" ];
then
    mkdir /var/www
    yum -y update


    # Install some utility items
    yum install -y git subversion vim make

    # Install sqlite and nodejs for javascript runtime
    yum install -y sqlite sqlite-devel nodejs

    #Install ruby build requires
    yum install -y openssl-devel readline-devel zlib-devel

    # Clone the rbenv repo from github
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    cd ~/.rbenv

    # Add rbenv to PATH
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
    source ~/.bash_profile

    # Install ruby-build
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

    # Install and use ruby 2.3
    rbenv install 2.3.0
    rbenv rehash
    rbenv global 2.3.0

    gem install rails
    gem install sqlite3 -v '1.3.7'
    gem install execjs

    source ~/.bash_profile

    # Create a default project
    rails new /vagrant/www/default

    # Set up the sites directory
    ln -s /vagrant/www /var/www
fi

cd /vagrant/www/default

# Start up the default server as a daemon
rails server -d -b 0.0.0.0 -e development -p 3000
