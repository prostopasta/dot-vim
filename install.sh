#!/usr/bin/env bash

echo " Script will install ShellCheck and ViM config"

mv .vim ~/.vim
mv .vimrc ~/.vimrc
if [ $? ] ; then
  echo "ViM configuration was updated"
else
  echo "Failed to install ViM config.."

# RedHat distros
sudo yum update -y
sudo yum install epel-release ShellCheck -y
if [ $? ] ; then
  echo "RedHat distros: ShellCheck installed"
else
  echo "RedHat distros: Failed to install ShellCheck.." 


# Ubuntu distros
sudo apt update -y
sudo apt install shellcheck -y
if [ $? ] ; then
  echo "Ubuntu distros: ShellCheck installed"
else
  echo "Ubuntu distros: Failed to install ShellCheck.." 

currdir=$PWD
cd ..
rm -rf $currdir
echo "Script completed. Exiting now."

