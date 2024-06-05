#!/usr/bin/env bash

# Line start for script messages
ss="--->"

function yes_or_no {
  while true; do
    read -rp "$ss $* [y/n]:" yesno
    case $yesno in
        [Yy]* )
            echo "$ss You answered yes"
            return 0
        ;;
        [Nn]* )
            echo "$ss You answered no"
            return 1
        ;;
        * ) echo "$ss Answer either yes or no!" ;;
    esac
  done
}

echo "$ss Script will install ShellCheck and ViM config"
if mv -ft ~ ./.vim ./.vimrc ; then
  echo "$ss ViM configuration was updated"
else
  echo "$ss Failed to install ViM config.."
fi

release=$(cat /etc/*-release | grep ID_LIKE=)
if [[ $release = *"rhel"* ]]; then 
	echo "$ss System is RHEL-based"; 
	cmd="sudo yum update -y && \
	     sudo yum install epel-release -y && \
	     sudo yum install ShellCheck -y
	     sudo yum install vim-enhanced -y"
	if [ "$(eval "$cmd")" ] ; then
  	  echo "$ss RedHat distros: ShellCheck installed"
	else
  	  echo "$ss RedHat distros: Failed to install ShellCheck.."
	fi
elif [[ $release = *"debian"* ]]; then
	echo "$ss System is DEBIAN-based"; 
	cmd="sudo apt update -y && sudo apt install shellcheck -y"
	if [ "$(eval "$cmd")" ] ; then
  	  echo "$ss Ubuntu distros: ShellCheck installed"
	else
  	  echo "$ss Ubuntu distros: Failed to install ShellCheck.."
	fi
fi

currdir=$PWD
if yes_or_no "Do you want to remove the cloned directory $currdir ?" && cd .. && rm -rf "$currdir" ; then
  echo "$ss Directory removed"
else
  echo "$ss Didnt remove the directory.."
fi

echo "$ss Script completed. Exiting now."
