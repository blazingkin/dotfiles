#!/bin/bash

RUBY_VERSION=2.4.1

# Install rbenv and set up global ruby
if [[ -z $(which rbenv) ]]
then
    echo "Installing rbenv"
    sudo apt-get install rbenv
    echo "Setting up rbenv install"
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build  
    echo "Installing ruby $RUBY_VERSION"
    rbenv install $RUBY_VERSION
    rbenv global $RUBY_VERSION
fi

# Install bundler
if [[ -z $(which bundle) ]]
then
    echo "Installing bundler"
    sudo gem install bundler
fi