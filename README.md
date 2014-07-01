Installing Kobocat / Koboform Development Box
=============================================

1. Ensure you have VirtualBox installed

	http://virtualbox.org

1. Download and install "Vagrant"

	http://www.vagrantup.com/downloads.html

1. Clone "kobotoolbox/dist-kobo-devel", branch: "vagrant"

	git clone https://github.com/kobotoolbox/dist-kobo-devel.git -b vagrant

1. Change directories

	cd dist-kobo-devel

1. Run "vagrant up"

	vagrant up

1. Wait (this process will take a long time, 30 mins+ depending on network connection)


Location of the code
--------------------

If the installation is successful, dist-kobo-devel should include the following git repositories inside

 * kobocat
 * kobocat-template
 * koboform
