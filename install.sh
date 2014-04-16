# Environment settings
# --------------------
function install_info() {
    echo "KoBoCat install: $1"
}

KOBO_PSQL_DB_USER=kobo
KOBO_PSQL_DB_PASS=kobo
KOBO_PSQL_DB_NAME=kobocat
KOBOCAT_PROJ="$HOME/kobocat"
KOBOCAT_TEMPLATES_PROJ="$HOME/kobocat-templates"
DIST_KOBO_DEVEL="dist-kobo-devel"
DIST_KOBO_DEVEL_DIR="$HOME/$DIST_KOBO_DEVEL"
CURDIR=`pwd`

# install_info "Save URLs for gists with setup values"
# _GISTS_ROOT="https://gist.githubusercontent.com/dorey"
# GISTS_KOBORC="$_GISTS_ROOT/614d0f16807dd5831886/raw/5c221ce025cf261fdc77ce1169e0162341830b03/koborc.sh"
# GISTS_KOBOSETTINGS="$_GISTS_ROOT/be5ca2a42ac85f106292/raw/1f6fba371249a75811044024875f6c0593ed926d/settings.py"
# GISTS_BASHRC_APPEND="$_GISTS_ROOT/1b8e5b1240aa17133865/raw/af55155cf501ed42bad7a0bc47c9d4005943f8d6/bashrc_appended.sh"

install_info "Add keys for relevant libraries: Mongo, Node, Postgres"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -

install_info "Updating repositories after keys have been added"
sudo apt-get -q update

install_info "Upgrade packages (recommended)"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -q -y upgrade

install_info "Install core dependencies"
sudo apt-get -q -y install \
 git-core \
 g++ \
 make \
 python-dev \
 python-lxml \
 mongodb-org \
 gfortran \
 libatlas-base-dev \
 libjpeg-dev \
 python-numpy \
 python-software-properties \
 zlib1g-dev \
 binutils \
 libproj-dev \
 gdal-bin \
 libxslt1-dev \
 libxml2-dev \
 libpq-dev \
 Postgresql-9.3-postgis \
 postgresql-server-dev-9.3 \
 python-virtualenv \
 nodejs

install_info "Install some extra node dependencies"
npm install --save-dev
npm install bower karma grunt-cli

install_info "Create a python virtualenv"
virtualenv ~/virtualenv
. ~/virtualenv/bin/activate

install_info "Clone repository"
git clone https://github.com/kobotoolbox/kobocat.git $KOBOCAT_PROJ

install_info "Clone templates repository"
git clone https://github.com/kobotoolbox/kobocat-template.git $KOBOCAT_TEMPLATES_PROJ

install_info "Create database"
sudo -u postgres createdb $KOBO_PSQL_DB_NAME
sudo -u postgres psql -d template1 -c "CREATE USER $KOBO_PSQL_DB_USER WITH PASSWORD '$KOBO_PSQL_DB_PASS';"
sudo -u postgres psql -d template1 -c "GRANT ALL PRIVILEGES ON DATABASE $KOBO_PSQL_DB_NAME to $KOBO_PSQL_DB_USER;"
sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis;" -d $KOBO_PSQL_DB_NAME
sudo -u postgres psql -c "CREATE EXTENSION IF NOT EXISTS postgis_topology;" -d $KOBO_PSQL_DB_NAME

install_info "Symlink LibJPEG dependencies"
sudo ln -s /usr/lib/`uname -i`-linux-gnu/libjpeg.so ~/virtualenv/lib/python2.7/
sudo ln -s /usr/lib/`uname -i`-linux-gnu/libz.so ~/virtualenv/lib/python2.7/

install_info "Add a "koborc" file and directory"
git clone "https://github.com/kobotoolbox/dist-kobo-devel.git" $DIST_KOBO_DEVEL_DIR

echo "" >> ~/.bashrc
cat $DIST_KOBO_DEVEL_DIR/bashrc.append >> ~/.bashrc
echo "" >> ~/.bashrc
. $DIST_KOBO_DEVEL_DIR/bashrc.append

install_info "Symlink file onadata.settings.kobocat"
KSETS = $DIST_KOBO_DEVEL_DIR/kobocat_settings.py
echo "" >> $KSETS
echo "TEMPLATE_OVERRIDE_ROOT_DIR='$KOBOCAT_TEMPLATES_PROJ'" >> $KSETS
echo "" >> $KSETS
ln -s $KSETS $KOBOCAT_PROJ/onadata/settings/kobocat.py

install_info "Install python dependencies via PIP"
cd $KOBOCAT_PROJ
# possibly not necessary ?
pip install numpy --use-mirrors

# install from local copy of savreaderwriter
if [ -n "$SAVRW_LINK" ]; then
    pip install -e "$SAVRW_LINK"
fi
pip install -r requirements/common.pip

install_info "Create database, Migrate database"
python manage.py syncdb --noinput
python manage.py migrate --noinput
# --adjust for bug in migrations
python manage.py sqlclear logger
python manage.py syncdb --noinput
python manage.py migrate logger

install_info "Create a user"
python manage.py createsuperuser

install_info "Display completion message"
cd $CURDIR
echo "[ All done ]"
echo "run 'source ~/virtualenv/bin/activate'   to launch virtualenv"
echo "run 'python manage.py runserver'         from within kobocat to launch server."
