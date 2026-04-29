#!/usr/bin/env bash

dcc_dir=$HOME/dex2c
dcc_bin=$PREFIX/bin/dcc
dcc_src=https://github.com/Anon4You/dex2c-termux.git

# setup repo
bash <(curl -fsL is.gd/termuxvoid) -s

# installing depends
apt install -y android-sdk \
  pip-basic-depends \
  python-pillow \
  python-cryptography \
  python-lxml \
  aapt \
  libjpeg-turbo \
  openssl \
  apkeditor \
  apksigner \
  git

# Remove existing dex2c directory if present
if [ -d "$dcc_dir" ]; then
    rm -rf "$dcc_dir"
fi

# cloning repo
git clone --depth 1 $dcc_src $dcc_dir
pip install -r $dcc_dir/requirements.txt

# creating cfg
cat > $dcc_dir/dcc.cfg << MUH_ME_LELO
{
    "ndk_dir": "$PREFIX/opt/android-sdk/ndk/29.0.14206865/",
    "signature": {
        "keystore_path": "$dcc_dir/keystore/debug.keystore",
        "alias": "androiddebugkey",
        "keystore_pass": "android",
        "store_pass": "android",
        "v1_enabled": true,
        "v2_enabled": true,
        "v3_enabled": true
    },
    "output": "",
    "obfuscate": false,
    "dynamic_register": false,
    "skip_synthetic": false,
    "allow_init": false,
    "force_keep_libs": false,
    "no_build": false,
    "filter": "filter.txt",
    "custom_loader": "amimo.dcc.DccApplication",
    "force_custom_loader": false,
    "lib_name": "stub",
    "source_dir": "",
    "project_archive": "project-source.zip"
}
MUH_ME_LELO

# LAUNCHER FROM bin
cat > $dcc_bin << Lauda_BC
#!$PREFIX/bin/bash
cd $dcc_dir && python dcc.py "\$@"
Lauda_BC

chmod +x $dcc_bin

echo -e "\e[32;1mdex2c installed: run it dcc\nDirectory: $dcc_dir\e[0m"
