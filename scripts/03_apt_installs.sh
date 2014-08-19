#!/bin/sh -u

# scripts/03_apt_installs.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. /vagrant/scripts/01_environment_vars.sh
# ============================

set -e

install_info "Install core dependencies"

sudo apt-get -q update
sudo apt-get -y upgrade

sudo apt-get -y --force-yes install \
    git-core \
    g++ \
    make \
    python-dev \
    python-lxml \
    mongodb-org-server \
    gfortran \
    libatlas-base-dev \
    libjpeg-dev \
    python-numpy \
    python-software-properties \
    zlib1g-dev \
    binutils \
    libproj-dev \
    libxslt1-dev \
    libxml2-dev \
    libpq-dev \
    rabbitmq-server \
    python-virtualenv \
    nodejs

sudo easy_install pip
sudo pip install virtualenvwrapper
