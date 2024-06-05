#!/usr/bin/env bash

# Line start for script messages
ss="--->"

function yes_or_no {
  while true; do
    read -rp "$* [y/n]:" yesno
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
cmd="mv ./.vim ~/.vim && mv ./.vimrc ~/.vimrc"
if [ "$cmd" ] ; then
  echo "$ss ViM configuration was updated"
else
  echo "$ss Failed to install ViM config.."
fi

# RedHat distros
cmd="sudo yum update -y && sudo yum install epel-release ShellCheck -y"
if [ "$cmd" ] ; then
  echo "$ss RedHat distros: ShellCheck installed"
else
  echo "$ss RedHat distros: Failed to install ShellCheck.."
fi

# Ubuntu distros
cmd="sudo apt update -y && sudo apt install shellcheck -y"
if [ "$cmd" ] ; then
  echo "$ss Ubuntu distros: ShellCheck installed"
else
  echo "$ss Ubuntu distros: Failed to install ShellCheck.."
fi

currdir=$PWD
cmd="yes_or_no \"Do you want to remove the cloned directory $currdir ?\" && cd .. && rm -rf $currdir"
if [ "$cmd" ] ; then
  echo "$ss Directory removed"
else
  echo "$ss Failed to remove directory.."
fi

echo "$ss Script completed. Exiting now."
