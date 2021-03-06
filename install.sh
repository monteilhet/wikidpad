#!/bin/bash

# run as root

sudo apt-get update -y
sudo apt-get install -y wget unzip whois # python-enchant python-pygments
sudo apt install libcanberra-gtk-module -y # libcanberra-gtk3-module -y
sudo apt install -y libenchant1c2a
# apt-get install -y python-wxgtk-2.8  # last avaibility ubuntu 14 trusty
# use offline backup and pyenv

sudo bash -c 'mkdir /opt/wikidpad'
sudo chown $(id -un): /opt/wikidpad
# create pyenv
cd /opt/wikidpad
# require pyenv 2.7.18 installed
if ! pyenv versions | grep 2.7.18$ ; then echo "pyenv 2.7.18 not found" ; exit 1 ; fi
pyenv virtualenv 2.7.18 wikidpad
pyenv local wikidpad
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade wheel
pip install pyenchant==3.0.0a1
pip install Pygments
cd -

cd wxgtk-2.8
SKIP_PYWX=1 ./install.sh
cd /opt/wikidpad

URL_WP="https://github.com/WikidPad/WikidPad/archive/WikidPad-2-3-rc02.zip"
# http://downloads.sourceforge.net/wikidpad/WikidPad-2.2-src.zip

cd /opt
wget -q ${URL_WP} -O /tmp/tmp.zip && unzip /tmp/tmp.zip -d wikidpad && rm -f /tmp/tmp.zip
cd  /opt/wikidpad/Wikid*
mv * ..


cat <<IN | sudo tee /usr/local/bin/wikidpad
#!/bin/bash

cd /opt/wikidpad
which pyenv || export PATH="/home/$(id -un)/.pyenv/shims:\${PATH}"

python2 WikidPad.py \$*
IN

sudo chmod 755 /usr/local/bin/wikidpad
# useradd -p $(mkpasswd user) -m -g users user

# git clone resources # done by ansible repos
# install icons and user extensions
mv /opt/wikidpad/icons /opt/wikidpad/icons~
ln -sf /opt/resources/icons/wikidpad-2.1_free_and_custom /opt/wikidpad/icons
ln -sf /opt/resources/wikidpad/user_extensions /opt/wikidpad/user_extensions

sed -i "/Delete/s/^/#/" /opt/wikidpad/extensions/KeyBindings.py

# user=$(id -un)
# color1="sed -i '/tree_bg_color/s/^.*$/tree_bg_color = #e0decf/' /home/${user}/.WikidPad.config"
# color2="sed -i '/html_body_bgcolor/s/^.*$/html_body_bgcolor = #e0decf/' /home/${user}/.WikidPad.config"
# color3="sed -i '/editor_bg_color/s/^.*$/editor_bg_color = #e0decf/' /home/${user}/.WikidPad.config"
# script="sed -i '/script_security_level/s/^.*$/script_security_level = 2/' /home/${user}/.WikidPad.config"

# eval $color1
# eval $color2
# eval $color3
# eval $script

WIKIDPAD_CONFIG="/home/$(id -un)/.WikidPad.config"
if [[ -f $WIKIDPAD_CONFIG ]] ; then
sed -i '/tree_bg_color/s/^.*$/tree_bg_color = #e0decf/' $WIKIDPAD_CONFIG
sed -i '/html_body_bgcolor/s/^.*$/html_body_bgcolor = #e0decf/' $WIKIDPAD_CONFIG
sed -i '/editor_bg_color/s/^.*$/editor_bg_color = #e0decf/' $WIKIDPAD_CONFIG
sed -i '/script_security_level/s/^.*$/script_security_level = 2/' $WIKIDPAD_CONFIG
fi

# create Favorites
mkdir -p "/home/$(id -un)/.WikidPadGlobals"
cat > "/home/$(id -un)/.WikidPadGlobals/[FavoriteWikis].wiki" <<IN
StyleWiki;n;=/home/$(id -un)/git/wikis/StyleWiki/StyleWiki.wiki
DevWiki;n;=/home/$(id -un)/git/wikis/DevWiki/DevWiki.wiki
SystemWiki;n;=/home/$(id -un)/git/wikis/SystemWiki/SystemWiki.wiki
PersoWiki;n;=/home/$(id -un)/git/wikis/Perso/PersoWiki/PersoWiki.wiki
JobWiki;n;=/home/$(id -un)/git/wikis/JobWiki/JobWiki.wiki
CuisineWiki;n;=/home/$(id -un)/git/wikis/Perso/CuisineWiki/CuisineWiki.wiki
OrangeLabs;n;=/home/$(id -un)/data/corporates/OrangeLabs/oln/OrangeLabs.wiki
MaisonWiki;n;=/home/$(id -un)/git/wikis/Perso/MaisonWiki/MaisonWiki.wiki
EnglishWiki;n;=/home/$(id -un)/git/wikis/Edu/EnglishWiki/EnglishWiki.wiki
Kast;n;=/home/$(id -un)/git/wikis/Corporate/Thales/Kast/Kast.wiki
MDS;n;=/home/$(id -un)/git/wikis/Corporate/Thales/MDS/MDS.wiki
Claranet;n;=/home/$(id -un)/git/Wikis/Corporate/Claranet/wiki/Claranet.wiki
IN

# | sudo tee /usr/share/applications/wikidpad.desktop
cat <<'IN' > ~/.local/share/applications/wikidpad.desktop
[Desktop Entry]
Encoding=UTF-8
Name=WikidPad
Comment=WikidPad application
Exec=wikidpad
Icon=/opt/wikidpad/Wikidpad_128x128x32.png
Terminal=false
Type=Application
Categories=GNOME;Application;
StartupNotify=true
IN
