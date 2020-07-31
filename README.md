# MAD_Competition

Matlab code for MAD Competition

Initial code provided by Zhou Wang.

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
