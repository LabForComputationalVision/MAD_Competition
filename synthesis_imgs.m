clear all;
close all;

for i=1:10
   for l=3:10
      sigma2 = 2^l;
      iter = [100 100 100 100];
      imname = ['data/ssim_images/samp' num2str(i) '.tif'];
      resname = ['data/results/samp' num2str(i) '_L' num2str(sigma2) '_results.mat'];
      fungds_mse_ssimweighted(sigma2, iter, imname, resname);
   end
end

