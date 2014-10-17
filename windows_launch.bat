@ECHO off

::Location and name of the .box file. File path is relative to Vagrantfile. 
set VM_BOX=boxes/kbox_latest.box
::Setting flag to offline to only load local file, not download all components fresh
set KOBO_OFFLINE=1

if not exist %VM_BOX% (
	echo.&&echo.
	echo Vagrant box file %VM_BOX% does not exist! Please download the 
	echo latest KoBoToolbox offline VM file into the /boxes folder
	echo.&&echo.&&echo.&&echo.
	pause
) else (
	echo.&&echo.&&echo.&&echo.
	echo KoBoToolbox Vagrant file has been found. Let's start it up...
	echo.&&echo.&&echo.&&echo.
	::Let's start the machine
	vagrant up 
	echo.&&echo.&&echo.&&echo.
	echo Your KoBoToolbox offline VM has been installed and is ready to go. 
	echo Open your browser and type in http://localhost:8000
	echo.
	echo Log in with username kobo and password kobo
	echo.&&echo.&&echo.&&echo.
	pause
)
