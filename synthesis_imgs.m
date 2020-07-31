clear all;
close all;

for i=1:10
   for l=3:10
      sigma2 = 2^l;
      iter = [2 1 1 5];
      imname = ['results/samp' num2str(i) '.tif'];
      resname = ['results/samp' num2str(i) '_L' num2str(sigma2) '_results.mat'];
      fungds_mse_ssimweighted(sigma2, iter, imname, resname);
   end
end

