#!/usr/bin/env bash
set -euo pipefail

wget https://osf.io/j65tw/download -O data/ssim_images/ssim_images.tar.gz
tar -xf data/ssim_images/ssim_images.tar.gz -C data/
rm data/ssim_images/ssim_images.tar.gz
