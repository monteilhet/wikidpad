#!/bin/bash

# sudo add-apt-repository ppa:linuxuprising/libpng12
# impish latest version available for libpng12
sudo bash -c "echo 'deb https://ppa.launchpadcontent.net/linuxuprising/libpng12/ubuntu/ impish main' > /etc/apt/sources.list.d/linuxuprising-ubuntu-libpng12-kinetic.list"

sudo apt update
sudo apt install libpng12-0 -y
sudo dpkg -i libwxbase2.8-0_2.8.12.1+dfsg2-ppa1~ubuntu16.04.1_amd64.deb
sudo dpkg -i libwxgtk2.8-0_2.8.12.1+dfsg2-ppa1~ubuntu16.04.1_amd64.deb
sudo dpkg -i libgstreamer0.10-0_0.10.36-1.5ubuntu1_amd64.deb
sudo dpkg -i libgstreamer-plugins-base0.10-0_0.10.36-2ubuntu0.1_amd64.deb
sudo dpkg -i libwxgtk-media2.8-0_2.8.12.1+dfsg2-ppa1\~ubuntu16.04.1_amd64.deb

#  use wxpy.tgz in virtualenv site-packages : ~/.pyenv/versions/wikidpad/lib/python2.7/site-packages/
# alternative install python wx wrapper
# test using : python -c 'import wx ; print wx.version()'
if [[ -z $INSTALL_PYWX ]] ; then
if [[ -d ~/.pyenv/versions/wikidpad/lib/python2.7/site-packages ]]; then
  tar xvf wxpy.tgz --strip-components=1 -C ~/.pyenv/versions/wikidpad/lib/python2.7/site-packages
else
  echo "ERROR no wikidpad virtualenv found in pyenv"
fi
else
sudo apt-get install python-wxversion
sudo dpkg -i python-wxgtk2.8_2.8.12.1+dfsg2-ppa1\~ubuntu16.04.1_amd64.deb
fi

