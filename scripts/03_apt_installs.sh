#!/bin/sh -u

# scripts/03_apt_installs.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
. ./01_environment_vars.sh
# ============================

set -e

install_info "Install core dependencies"

sudo apt-get -qq update
sudo apt-get -qq upgrade

sudo apt-get -qq --force-yes install \
    git-core \
    g++ \
    make \
    python-dev \
    mongodb-org-server \
    gfortran \
    libatlas-base-dev \
    libjpeg-dev \
    python-numpy \
    python-software-properties \
    openjdk-6-jre \
    zlib1g-dev \
    binutils \
    libproj-dev \
    libxslt1-dev \
    libxml2-dev \
    python-lxml \
    libpq-dev \
    rabbitmq-server \
    python-virtualenv \
    nodejs

sudo easy_install pip
sudo pip install virtualenvwrapper
