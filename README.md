Installing Kobocat / Koboform Development Box
=============================================

1. ensure you have [virtualbox](http://virtualbox.org) and [vagrant](http://www.vagrantup.com/downloads.html) installed

1. In the "dist-kobo-devel" project, run `vagrant up`

1. Wait (this process will take a long time, 30 mins+ depending on network connection)

1. Open your browser to [http://localhost:8000](http://localhost:8000) and log in with the credentials username `kobo` and password `kobo`.

1. You can now run these commands from within this directory

 * `vagrant ssh` # ssh into the virtual machine
 * `vagrant reload --provision` # reload the provision script after pulling the latest code

How to load from an existing .box file
--------------------------------------
 * Clone this repository.
 * Set an environment variable `VM_BOX` to equal to the path to the box file, and then run `vagrant up`.

_Linux/OS X example_

`export VM_BOX="file:///path/to/box.box" && vagrant up`

_Windows example_

`set VM_BOX=box.box && vagrant up`

Additional commands to know
---------------------------
 * `vagrant destroy` # deletes the vagrant box
 * `vagrant halt` or `vagrant suspend` # shuts down the machine


In development mode
-------------------

Clone these projects into a directory "dist-kobo-devel/src":

 * [koboform (aka dkobo, django kobo)](https://github.com/kobotoolbox/dkobo) - _for creating surveys_
 * [kobocat](https://github.com/kobotoolbox/kobocat) - _for deploying surveys_
 * [kobocat-templates](https://github.com/kobotoolbox/kobocat-template) - _a project meant to avoid forking the above forked project_
 * [enketo-express](https://github.com/kobotoolbox/enketo-express/) - _html5 survey previewer / player / editor_
