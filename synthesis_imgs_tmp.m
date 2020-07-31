clear all;
close all;

for i=2:2
   for l=10:10
      sigma2 = 2^l;
      iter = [1 1 100 1];
      imname = ['results/samp' num2str(i) '.tif'];
      %      resname = ['results/samp' num2str(i) '_L' num2str(sigma2) '_results.mat'];
      resname = 'results/tmp.mat';
      fungds_mse_ssimweighted_tmp(sigma2, iter, imname, resname);
   end
end

