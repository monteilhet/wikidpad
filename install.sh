#!/bin/bash

# run as root

apt-get update -y
apt-get install -y python-enchant python-pygments wget unzip whois
# apt-get install -y python-wxgtk-2.8
wxgtk-2.8/install.sh

URL_WP="https://github.com/WikidPad/WikidPad/archive/WikidPad-2-3-rc02.zip"
# http://downloads.sourceforge.net/wikidpad/WikidPad-2.2-src.zip

mkdir /opt/wikidpad
cd /opt
wget -q ${URL_WP} -O /tmp/tmp.zip && unzip /tmp/tmp.zip -d wikidpad && rm /tmp/tmp.zip
cd  /opt/wikidpad/Wikid*
mv * ..

cat <<'IN' > /usr/local/bin/wikidpad
#!/bin/bash

cd /opt/wikidpad
python WikidPad.py $*
IN

chmod 755 /usr/local/bin/wikidpad
# useradd -p $(mkpasswd user) -m -g users user

# git clone resources # done by ansible repos
# install icons and user extensions
mv /opt/wikidpad/icons /opt/wikidpad/icons~
ln -sf /opt/resources/icons/wikidpad-2.1_free_and_custom /opt/wikidpad/icons
ln -sf /opt/resources/wikidpad/user_extensions /opt/wikidpad/user_extensions

sed -i "/Delete/s/^/#/" /opt/wikidpad/extensions/KeyBindings.py

user=user
color1="sed -i '/tree_bg_color/s/^.*$/tree_bg_color = #e0decf/' /home/${user}/.WikidPad.config"
color2="sed -i '/html_body_bgcolor/s/^.*$/html_body_bgcolor = #e0decf/' /home/${user}/.WikidPad.config"
color3="sed -i '/editor_bg_color/s/^.*$/editor_bg_color = #e0decf/' /home/${user}/.WikidPad.config"
script="sed -i '/script_security_level/s/^.*$/script_security_level = 2/' /home/${user}/.WikidPad.config"

eval $color1
eval $color2
eval $color3
eval $script

# create Favorites
cat > "/home/user/.WikidPadGlobals/[FavoriteWikis].wiki" <<IN
StyleWiki;n;=/home/user/git/wikis/StyleWiki/StyleWiki.wiki
DevWiki;n;=/home/user/git/wikis/DevWiki/DevWiki.wiki
SystemWiki;n;=/home/user/git/wikis/SystemWiki/SystemWiki.wiki
PersoWiki;n;=/home/user/git/wikis/Perso/PersoWiki/PersoWiki.wiki
JobWiki;n;=/home/user/git/wikis/JobWiki/JobWiki.wiki
CuisineWiki;n;=/home/user/git/wikis/Perso/CuisineWiki/CuisineWiki.wiki
OrangeLabs;n;=/home/user/data/corporates/OrangeLabs/oln/OrangeLabs.wiki
MaisonWiki;n;=/home/user/git/wikis/Perso/MaisonWiki/MaisonWiki.wiki
EnglishWiki;n;=/home/user/git/wikis/Edu/EnglishWiki/EnglishWiki.wiki
Claranet;n;=/home/user/data/corporates/Claranet/wiki/Claranet.wiki
IN
