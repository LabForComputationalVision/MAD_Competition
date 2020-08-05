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
