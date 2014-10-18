echo 'running apt installs'

add-apt-repository -y ppa:rwky/redis
apt-get update
apt-get install -y 

# install XML prerequisites for node_xslt
apt-get install -y libxml2-dev \
                   redis-server \
                   git \
                   libxslt1-dev \
                   python-software-properties \
                   python \
                   g++ \
                   make

easy_install nodeenv

# install dependencies, development tools, node, grunt
