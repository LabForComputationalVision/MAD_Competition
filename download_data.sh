#!/usr/bin/env bash
set -euo pipefail

wget https://osf.io/gbuv6/download -O data/images/images.zip
unzip data/images/images.zip -d data/images/
rm data/images/images.zip
