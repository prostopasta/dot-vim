#!/usr/bin/env bash

function yes_or_no {
  while true; do
    read -p "$* [y/n]:" yesno
    case $yesno in
        [Yy]* ) 
            echo "You answered yes"
	    return 0
        ;;
        [Nn]* ) 
            echo "You answered no"
            return 1
        ;;
        * ) echo "Answer either yes or no!" ;;
    esac
  done
}


echo " Script will install ShellCheck and ViM config"

mv ./.vim ~/.vim
mv ./.vimrc ~/.vimrc
if [ $? -eq 0 ] ; then
  echo "ViM configuration was updated"
else
  echo "Failed to install ViM config.."
fi

# RedHat distros
sudo yum update -y && sudo yum install epel-release ShellCheck -y
if [ $? -eq 0 ] ; then
  echo "RedHat distros: ShellCheck installed"
else
  echo "RedHat distros: Failed to install ShellCheck.." 
fi

# Ubuntu distros
sudo apt update -y && sudo apt install shellcheck -y
if [ $? -eq 0 ] ; then
  echo "Ubuntu distros: ShellCheck installed"
else
  echo "Ubuntu distros: Failed to install ShellCheck.." 
fi

currdir=$PWD
yes_or_no "Do you want to remove the cloned directory $currdir ?" && cd .. && rm -rf $currdir
if [ $? -eq 0 ] ; then
  echo "Directory removed"
else
  echo "Failed to remove directory.." 
fi

echo "Script completed. Exiting now."
