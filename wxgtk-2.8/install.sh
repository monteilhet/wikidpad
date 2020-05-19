#!/bin/bash

# skip original package libpng no more coexisting with newer version of libpng 16
# sudo dpkg -i libpng12-0_1.2.54-1ubuntu1_amd64.deb
# use libpng12 fake package to avoid dependencies breaking and copy libraries 
sudo dpkg -i libpng12-0_1.2.54_amd64.deb
sudo cp libpng12.so* /usr/lib/x86_64-linux-gnu
sudo dpkg -i libwxbase2.8-0_2.8.12.1+dfsg2-ppa1~ubuntu16.04.1_amd64.deb
sudo dpkg -i libwxgtk2.8-0_2.8.12.1+dfsg2-ppa1~ubuntu16.04.1_amd64.deb
sudo dpkg -i libgstreamer0.10-0_0.10.36-1.5ubuntu1_amd64.deb
sudo dpkg -i libgstreamer-plugins-base0.10-0_0.10.36-2ubuntu0.1_amd64.deb
sudo dpkg -i libwxgtk-media2.8-0_2.8.12.1+dfsg2-ppa1\~ubuntu16.04.1_amd64.deb
sudo apt-get install python-wxversion
sudo dpkg -i python-wxgtk2.8_2.8.12.1+dfsg2-ppa1\~ubuntu16.04.1_amd64.deb


