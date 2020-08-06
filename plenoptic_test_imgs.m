clear all;
close all;

sigma2 = 128;
imNum = 6;
iter = [100 100 100 100];
imname = ['data/ssim_images/samp' num2str(imNum) '.tif'];
resname = ['data/results/samp' num2str(imNum) '_L' num2str(sigma2) '_results.mat'];
fungds_mse_ssimweighted(sigma2, iter, imname, resname);
