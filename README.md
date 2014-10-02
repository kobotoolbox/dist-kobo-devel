Installing Kobocat / Koboform Development Box
=============================================

1. ensure you have [virtualbox](http://virtualbox.org) and [vagrant](http://www.vagrantup.com/downloads.html) installed

1. In the "dist-kobo-devel" project, run `vagrant up`

1. Wait (this process will take a long time, 30 mins+ depending on network connection)

1. Open your browser to [http://localhost:8000](http://localhost:8000) and log in with the credentials username `kobo` and password `kobo`.

1. You can now run these commands from within this directory

 * `vagrant ssh`
 * `vagrant destroy` (deletes the vagrant box)
 * `vagrant halt` or `vagrant suspend`
 * `vagrant reload --provision` (reruns the init script)
 * `vagrant rsync` (runs a one-time sync of any commands in this directory)
 * `vagrant rsync-auto` (watches folders in the src directory for changes)

In development mode
-------------------

Clone these projects into a directory "dist-kobo-devel/src":

 * [koboform (aka dkobo, django kobo)](https://github.com/kobotoolbox/dkobo) - _for creating surveys_
 * [kobocat](https://github.com/kobotoolbox/kobocat) - _for deploying surveys_
 * [kobocat-templates](https://github.com/kobotoolbox/kobocat-template) - _a project meant to avoid forking the above forked project_
 * [enketo-express](https://github.com/kobotoolbox/enketo-express/) - _html5 survey previewer / player / editor_
