# MAD_Competition

Matlab code for MAD Competition

Initial versions of all code provided by Zhou Wang via email in July 2020,
except for the following:

 - `ssim_inex.m` downloaded from [Lab for Computational Vision
   website](https://www.cns.nyu.edu/~lcv/ssim/) in July 2020
 - contents of the `msssim` folder downloaded from [Zhou Wang's
   website](https://ece.uwaterloo.ca/~z70wang/research/iwssim/) in August 2020.

## Download data

Images used to generate synthesized images found on the
[OSF](https://osf.io/gbuv6/). If you have `wget` installed on your system (you
probably do: run `which wget` from the command line and, if it prints a path,
you do), you can use the included `download_data.sh` script: from the command
line, run `./download_data.sh`, and it will download the data, unzip the images,
and remove the zip file.

## Requirements

- MATLAB (not sure of version right now, but works at least for R2018b)
- [matlabPyrTools](https://github.com/LabForComputationalVision/matlabPyrTools)

Add `matlabPyrTools` to your path before running any of these functions

# Contents

This file contains the files to calculate SSIM (standard and weighted) and
MS-SSIM, as well as to run MAD Competition with the weighted version SSIM, as
shown in the paper. We primarily are using it to check the outputs of
[plenoptic's](https://github.com/LabForComputationalVision/plenoptic/)
implementation of SSIM and to synthesize images for comparison.

# Use

The primary function is `fungds_mse_ssimweighted.m`, which synthesizes a
complete set of MAD Competition images (four: two that fix SSIM and min/max MSE,
two that fix MSE and min/max SSIM) and saves the output. Its call signature is

`fungds_mse_ssimweighted(mse, iter, img, save_path)`

where `mse` is the amount of noise added (equivalent to `initial_noise` in
plenoptic, this is the fixed MSE value), `iter` is a 1d matrix with 4 values
(e.g., `[10 10 10 10]`) that gives the number of iterations for each image (in
order: fix MSE max SSIM, fix MSE min SSIM, fix SSIM min MSE, fix SSIM max MSE;
note that for SSIM max is best and min is worst, while it's the opposite for
MSE), `img` is the path to the target image, and `save_path` is the path to save
the results at (as a `.mat`) file.

`synthesis_imgs.m` is a wrapper function, which will create each of these for
the 10 sample images we provide and noise levels going from 8 to 1024
(log-spaced), with 100 iterations per image.

`plenoptic_analysis.m` saves several SSIM values (both weighted and standard)
for use in plenoptic's tests. We then upload this manually to the OSF page.
