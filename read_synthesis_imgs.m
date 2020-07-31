clear all;
close all;

for i=1:10
   for l=10:10
      sigma2 = 2^l;
      imname = ['results/samp' num2str(i) '.tif'];
      resname = ['results/samp' num2str(i) '_L' num2str(sigma2) '_results.mat'];
      im = double(imread(imname));
      load(resname);
      figure(i*100+l);
		subplot(3,3,1), showIm(im, [0,255], 1);
		subplot(3,3,5), showIm(im_init, [0,255], 1);
		subplot(3,3,2), showIm(im_fixmse_maxssim, [0,255], 1);
		subplot(3,3,8), showIm(im_fixmse_minssim, [0,255], 1);
      subplot(3,3,4), showIm(im_fixssim_minmse, [0,255], 1);
		subplot(3,3,6), showIm(im_fixssim_maxmse, [0,255], 1);
   end
end

