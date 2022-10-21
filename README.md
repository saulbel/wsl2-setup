# wsl2-setup
## Prerequisites
* `Windows 10 or 11`

## Project structure
```
wsl2-setup 
└── scripts
     └── debian_backup.ps1
     └── ssh_port_forwarding_debian.ps1
```
## Tasks to accomplish
- We are gonna install `wsl` and all the features needed for a development setup.

## First step: install WSL
The first thing we have to do is to install `wsl`. So we open our Powershell with `admin` rights. To check all available linux distros:
````
wsl --list --online
````
Then we install the one we want:
````
wsl --install -d <Distribution Name>
````
Here we have some usefull commands:
````
# list all installed distros
wsl -l

# start distro
wsl -d <Distribution Name>

# shutdown distro
wsl -t <Distribution Name>

# shutdown all distros
wsl --shutdown
````

## Second step: install Windows terminal (optional)
- If you are going to install more than one distro, I recommend you to install `Windows terminal`. It supports as many command lines as you would like to install and it is quite customizable.

## Third step: enable systemd
- If you are using `Windows 11`, there is already an official way to enable [it](https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/). 
- If you are still using `Windows 10` like myself, we are gonna use these [instructions](https://gist.github.com/djfdyuruiry/6720faa3f9fc59bfdf6284ee1f41f950). Basically we have to:
- Inside our `wsl` distro:
````
cd /tmp
wget --content-disposition \  "https://gist.githubusercontent.com/djfdyuruiry/6720faa3f9fc59bfdf6284ee1f41f950/raw/952347f805045ba0e6ef7868b18f4a9a8dd2e47a/install-sg.sh"

chmod +x /tmp/install-sg.sh

/tmp/install-sg.sh && rm /tmp/install-sg.sh
````
- In our `cmd` or `powershell` console:
````
wsl --shutdown
wsl genie -s
````
- Finally to prove that everything is working:
````
sudo systemctl status time-sync.target
````
- If we have installed `Windows terminal`, we are gonna go to Settings --> Profiles --> OurDistro --> Command line 
````
wsl -d <DistroName> genie -s
````
- So each time that we launch our distro, it will start with `systemd` enabled.


## Fourth step: enable ssh
- Let's say that we want to ssh into our `wsl` distro and have all our work/projects there. Each time we reset our pc, `wsl` will have a different IP. So in order to bypass this, we are gonna use `ssh_port_forwarding_debian.ps1`. 

- I recommend you to add it to `Task Scheduler` so each time you boot up your pc, it will be executed. These are the arguments that I use:
````
-File D:\WSL\Scripts\ssh_port_forwarding_debian.ps1 -ExecutionPolicy Bypass -WindowStyle Hidden -noProfile -noInteractive
````

- How do we connect to our `wsl` distro? First we need to get our `ipv4` address, so we are gonna open a `cmd` or `powershell` and we are gonna use `ifconfig` in order to get it. Then we can just connect to our `wsl` instance like this:
````
# ssh (windows hostname)@(ipv4 address) -p 2222 
ssh saul@192.168.1.139 -p 2222
````
- If everything is ok, it will ask for our `windows login` password.

- If we also start our prefer distro automatically with just login into our computer we can have `ssh` access. In order to this, we need `Windows Terminal`. To activate this, we go to Settings --> Startup --> Default Profile (here we select our Linux distro) --> Launch on machine startup.

## Fifth step: backup plan
- Finally I have included a backup script `debian_backup.ps1`. This script I also recommend you to add it to `Task Scheduler` and you can execute it once a week for example. This way you will always have at least a copy of all your projects. If you wanna use it, you will have to edit the `path` of both, your `wsl distro` and where you wanna the backup to be stored.
- Here are some useful backup commands:
````
# export Debian (DistroName) into a .tar file
wsl --export Debian debian.tar

# import Debian (Distroname), location where it will be and backup location
wsl --import Debian D:\WSL\Debian D:\WSL\Debian\debian_post_git.tar

# eliminate my Debian Wsl instance
wsl --unregister Debian
````
