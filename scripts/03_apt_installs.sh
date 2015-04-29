#!/usr/bin/env sh

# scripts/03_apt_installs.sh

# ============================
# EXTEND ENVIRONMENT VARIABLES
if [ -d /home/vagrant ]; then
    SCRIPT_DIR=/home/vagrant/scripts
else
    THIS_SCRIPT_PATH=$(readlink -f "$0")
    SCRIPT_DIR=$(dirname "$THIS_SCRIPT_PATH")
fi
. $SCRIPT_DIR/01_environment_vars.sh
# ============================

[ -n "$KOBO_SKIP_INSTALL" ] && exit 0

set -e

install_info "Install core dependencies"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y --force-yes install \
    git-core \
    g++ \
    make \
    python-dev \
    mongodb-org-server \
    gfortran \
    libatlas-base-dev \
    libjpeg-dev \
    python-numpy \
    python-pandas \
    python-software-properties \
    openjdk-6-jre \
    zlib1g-dev \
    binutils \
    libproj-dev \
    libxslt1-dev \
    libxml2-dev \
    libmemcached-dev \
    python-lxml \
    libpq-dev \
    rabbitmq-server \
    python-virtualenv \
    nodejs

sudo easy_install pip

[ $CLEAN_APT_CACHE = "True" ] && sudo apt-get clean # Clear out cached packages.
