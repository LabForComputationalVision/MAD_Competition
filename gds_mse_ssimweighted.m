clear all;
close all;

Iter1 = 200;
Iter2 = 50;
Iter3 = 50;
Iter4 = 500;
sigma2 = 256;
%constraint_range = min(2*sqrt(sigma2), 64);
constraint_range = 255;

im = double(imread('samp6.tif'));

% initial image: im + Gaussain Noise
n0 = 20*randn(size(im));
n0 = n0 - mean2(n0);
n0 = n0*sqrt(sigma2/mean2(n0.^2));
init_im = n0 + im;
FIX_MSE = mean2((im - init_im).^2)
FIX_SSIM = ssim_index(init_im, im, [0.01 0.03], ones(8))
im_init = init_im;

best_im = init_im;
for i=1:Iter1
   dmse = derivative_mse(best_im, im);
   dssim = derivative_ssim_weighted(best_im, im);
   len_dmse = sum(dmse.*dmse);
   %lamda = max(25, 100 - 0.1*i);   
   lamda = 10000;
   best_im = best_im + lamda*(dssim - (sum(dssim.*dmse)/len_dmse)*dmse);
   best_im = value_constraint(best_im, im, constraint_range);
   best_im = im + sqrt(FIX_MSE/mean2((best_im - im).^2))*(best_im - im);

   mse = mean2((best_im - im).^2);
   ssim = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

worst_im = init_im;
for i=1:Iter2
   dmse = derivative_mse(worst_im, im);
   dssim = derivative_ssim_weighted(worst_im, im);
   len_dmse = sum(dmse.*dmse);
   %lamda = max(25, 100 - 0.1*i);
   lamda = 10000;
   worst_im = worst_im - lamda*(dssim - (sum(dssim.*dmse)/len_dmse)*dmse);
   worst_im = value_constraint(worst_im, im, constraint_range);
   worst_im = im + sqrt(FIX_MSE/mean2((worst_im - im).^2))*(worst_im - im);

   mse = mean2((worst_im - im).^2);
   ssim = ssim_weighted(worst_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

mse1 = mean2((best_im - im).^2);
ssim1 = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
[mse1/10000 ssim1 mse/10000 ssim]

im_fixmse_maxssim = best_im;
im_fixmse_minssim = worst_im;
maxssim = ssim1;
minssim = ssim;

figure(21);
subplot(3,3,1), showIm(im, [0,255], 1);
subplot(3,3,5), showIm(init_im, [0,255], 1);
subplot(3,3,2), showIm(best_im, [0,255], 1);
subplot(3,3,8), showIm(worst_im, [0,255], 1);

idim = init_im - im;
bdim = best_im - im;
wdim = worst_im - im;
figure(22);
subplot(3,3,1), showIm(128*ones(size(im)),[0,255],1);
subplot(3,3,5), showIm(128 + idim,[0,255],1);
subplot(3,3,2), showIm(128 + bdim,[0,255],1);
subplot(3,3,8), showIm(128 + wdim,[0,255],1);

[ssim omap] = ssim_weighted(im, im, [0.01 0.03], ones(8));
[ssim imap] = ssim_weighted(init_im, im, [0.01 0.03], ones(8));
[ssim bmap] = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
[ssim wmap] = ssim_weighted(worst_im, im, [0.01 0.03], ones(8));
figure(23);
subplot(3,3,1), showIm(omap.^2,[0,1],1);
subplot(3,3,5), showIm(imap.^2,[0,1],1);
subplot(3,3,2), showIm(bmap.^2,[0,1],1);
subplot(3,3,8), showIm(wmap.^2,[0,1],1);

best_im = init_im;
lamda = 0.1;
lamda2 = -1;
for i=1:Iter3
   dmse = derivative_mse(best_im, im);
   dssim = derivative_ssim_weighted(best_im, im);
   len_dssim = sum(dssim.*dssim);
   best_im = best_im - lamda*(dmse - (sum(dmse.*dssim)/len_dssim)*dssim);
   best_im = value_constraint(best_im, im, constraint_range);

   ssim_b = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
   dssim = derivative_ssim_weighted(best_im, im);
   tmp_im = best_im + lamda2*dssim;
   ssim_t = ssim_weighted(tmp_im, im, [0.01 0.03], ones(8));
   lamda2 = lamda2*(FIX_SSIM - ssim_b)/(ssim_t - ssim_b);
   best_im = best_im + lamda2*dssim;

	mse = mean2((best_im - im).^2);
   ssim = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

worst_im = init_im;
lamda = 0.1;
lamda2 = 0.00001;
for i=1:Iter4
   dmse = derivative_mse(worst_im, im);
   dssim = derivative_ssim_weighted(worst_im, im);
   len_dssim = sum(dssim.*dssim);
   worst_im = worst_im + lamda*(dmse - (sum(dmse.*dssim)/len_dssim)*dssim);
   
   ssim_w = ssim_weighted(worst_im, im, [0.01 0.03], ones(8));
   dssim = derivative_ssim_weighted(worst_im, im);
   tmp_im = worst_im + lamda2*dssim;
   ssim_t = ssim_weighted(tmp_im, im, [0.01 0.03], ones(8));
   lamda2 = lamda2*(FIX_SSIM - ssim_w)/(ssim_t - ssim_w);
   worst_im = worst_im + lamda2*dssim;
   worst_im = value_constraint(worst_im, im, constraint_range);

	mse = mean2((worst_im - im).^2);
   ssim = ssim_weighted(worst_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
   
   if abs(ssim - FIX_SSIM)>0.0003
      lamda = lamda/2;
   end
end

mse1 = mean2((best_im - im).^2);
ssim1 = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
[mse1/10000 ssim1 mse/10000 ssim]

im_fixssim_minmse = best_im;
im_fixssim_maxmse = worst_im;
minmse = mse1;
maxmse = mse;

figure(21);
subplot(3,3,4), showIm(best_im, [0,255], 1);
subplot(3,3,6), showIm(worst_im, [0,255], 1);

bdim = best_im - im;
wdim = worst_im - im;
figure(22);
subplot(3,3,4), showIm(128 + bdim,[0,255],1);
subplot(3,3,6), showIm(128 + wdim,[0,255],1);

[ssim bmap] = ssim_weighted(best_im, im, [0.01 0.03], ones(8));
[ssim wmap] = ssim_weighted(worst_im, im, [0.01 0.03], ones(8));
figure(23);
subplot(3,3,4), showIm(bmap.^2,[0,1],1);
subplot(3,3,6), showIm(wmap.^2,[0,1],1);

save L256_results im_init im_fixmse_maxssim im_fixmse_minssim im_fixssim_minmse im_fixssim_maxmse maxssim minssim minmse maxmse FIX_MSE FIX_SSIM