#!/usr/bin/env bash

# Line start for script messages
ss="--->"

function yes_or_no {
  while true; do
    read -p "$* [y/n]:" yesno
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

mv ./.vim ~/.vim
mv ./.vimrc ~/.vimrc
if [ $? -eq 0 ] ; then
  echo "$ss ViM configuration was updated"
else
  echo "$ss Failed to install ViM config.."
fi

# RedHat distros
sudo yum update -y && sudo yum install epel-release ShellCheck -y
if [ $? -eq 0 ] ; then
  echo "$ss RedHat distros: ShellCheck installed"
else
  echo "$ss RedHat distros: Failed to install ShellCheck.." 
fi

# Ubuntu distros
sudo apt update -y && sudo apt install shellcheck -y
if [ $? -eq 0 ] ; then
  echo "$ss Ubuntu distros: ShellCheck installed"
else
  echo "$ss Ubuntu distros: Failed to install ShellCheck.." 
fi

currdir=$PWD
yes_or_no "Do you want to remove the cloned directory $currdir ?" && cd .. && rm -rf $currdir
if [ $? -eq 0 ] ; then
  echo "$ss Directory removed"
else
  echo "$ss Failed to remove directory.." 
fi

echo "$ss Script completed. Exiting now."
