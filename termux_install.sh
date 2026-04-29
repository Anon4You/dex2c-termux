#!/usr/bin/env bash
dcc_dir=$PREFIX/share/dex2c
dcc_bin=$PREFIX/bin/dcc 
dcc_src=https://github.com/Anon4You/dex2c-termux.git
ollvm_enable=false

# setup repo
bash <(curl -fsL is.gd/termuxvoid) -s

# installing depends
apt install -y android-sdk \
  pip-basic-depends \
  python-pillow \
  python-cryptography \
  python-lxml \
  ndk-sysroot \
  zlib \
  libjpeg-turbo \
  openssl \
  apktool \
  git

# cloning repob
git clone --depth 1 $dcc_src $dcc_dir
pip install -r $dcc_dir/requirements.txt

# creating cfg 

cat > $dcc_dir/dcc.cfg << MUH_ME_LELO
{
    "apktool": "$PREFIX/share/apktool/apktool.jar",
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
    "ollvm": {
        "enable": $ollvm_enable,
        "flags": "-fvisibility=hidden -mllvm -fla -mllvm -split -mllvm -split_num=5 -mllvm -sub -mllvm -sub_loop=5 -mllvm -sobf -mllvm -bcf_loop=5 -mllvm -bcf_prob=100"
    }
}
MUH_ME_LELO

cat > $dcc_bin << Lauda_BC
#!$PREFIX/bin/bash
cd $dcc_dir && python dcc.py "\$@"
Lauda_BC

chmod +x $dcc_bin


