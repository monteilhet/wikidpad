
NB from ubuntu 19.04 pbm to install libpng12
=> use a fake package using equivs and copy libpng.so in /usr/lib
libpng12-0_1.2.54_dummy_amd64.deb
libpng12.so.0
libpng12.so.0.54.0

# generate libpng12-0_1.2.54_amd64.deb package
equivs-build libpng
