#!/usr/bin/env bash

set -e


# X_teardown.bash

rm -rf /vagrant/kobocat
rm -rf /vagrant/kobocat-template
rm -rf /vagrant/koboform
rm -rf /home/vagrant/.virtualenvs

sudo -u postgres dropdb kobotoolbox
sudo -u postgres psql -d template1 -c "DROP USER kobo;"
