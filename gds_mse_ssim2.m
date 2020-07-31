clear all;
close all;

Iter1 = 100;
Iter2 = 100;
Iter3 = 100;
Iter4 = 100;
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

best_im = init_im;
for i=1:Iter1
   dmse = derivative_mse(best_im, im);
   dssim = derivative_ssim2(best_im, im);
   len_dmse = sum(dmse.*dmse);
   lamda = max(25, 100 - 0.1*i);   %lamda = 10;
   best_im = best_im + lamda*(dssim - (sum(dssim.*dmse)/len_dmse)*dmse);
   best_im = value_constraint(best_im, im, constraint_range);
   best_im = im + sqrt(FIX_MSE/mean2((best_im - im).^2))*(best_im - im);

	mse = mean2((best_im - im).^2);
   ssim = ssim2_index(best_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

worst_im = init_im;
for i=1:Iter2
   dmse = derivative_mse(worst_im, im);
   dssim = derivative_ssim2(worst_im, im);
   len_dmse = sum(dmse.*dmse);
   lamda = max(25, 100 - 0.1*i);	%lamda = 10;
   worst_im = worst_im - lamda*(dssim - (sum(dssim.*dmse)/len_dmse)*dmse);
   worst_im = value_constraint(worst_im, im, constraint_range);
   worst_im = im + sqrt(FIX_MSE/mean2((worst_im - im).^2))*(worst_im - im);

   mse = mean2((worst_im - im).^2);
   ssim = ssim2_index(worst_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

mse1 = mean2((best_im - im).^2);
ssim1 = ssim2_index(best_im, im, [0.01 0.03], ones(8));
[mse1/10000 ssim1 mse/10000 ssim]

figure(21);
subplot(3,3,1), showim(im, [0,255], 1);
subplot(3,3,5), showim(init_im, [0,255], 1);
subplot(3,3,2), showim(best_im, [0,255], 1);
subplot(3,3,8), showim(worst_im, [0,255], 1);

idim = init_im - im;
bdim = best_im - im;
wdim = worst_im - im;
figure(22);
subplot(3,3,1), showim(128*ones(size(im)),[0,255],1);
subplot(3,3,5), showim(128 + idim,[0,255],1);
subplot(3,3,2), showim(128 + bdim,[0,255],1);
subplot(3,3,8), showim(128 + wdim,[0,255],1);

[ssim omap] = ssim2_index(im, im, [0.01 0.03], ones(8));
[ssim imap] = ssim2_index(init_im, im, [0.01 0.03], ones(8));
[ssim bmap] = ssim2_index(best_im, im, [0.01 0.03], ones(8));
[ssim wmap] = ssim2_index(worst_im, im, [0.01 0.03], ones(8));
figure(23);
subplot(3,3,1), showim(omap.^2,[0,1],1);
subplot(3,3,5), showim(imap.^2,[0,1],1);
subplot(3,3,2), showim(bmap.^2,[0,1],1);
subplot(3,3,8), showim(wmap.^2,[0,1],1);

best_im = init_im;
lamda = 0.01;
lamda2 = -1;
for i=1:Iter3
   dmse = derivative_mse(best_im, im);
   dssim = derivative_ssim2(best_im, im);
   len_dssim = sum(dssim.*dssim);
   best_im = best_im - lamda*(dmse - (sum(dmse.*dssim)/len_dssim)*dssim);
   best_im = value_constraint(best_im, im, constraint_range);

   ssim_b = ssim2_index(best_im, im, [0.01 0.03], ones(8));
   dssim = derivative_ssim2(best_im, im);
   tmp_im = best_im + lamda2*dssim;
   ssim_t = ssim2_index(tmp_im, im, [0.01 0.03], ones(8));
   lamda2 = lamda2*(FIX_SSIM - ssim_b)/(ssim_t - ssim_b);
   best_im = best_im + lamda2*dssim;

	mse = mean2((best_im - im).^2);
   ssim = ssim2_index(best_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

worst_im = init_im;
lamda = 0.01;
lamda2 = 1;
for i=1:Iter4
   dmse = derivative_mse(worst_im, im);
   dssim = derivative_ssim2(worst_im, im);
   len_dssim = sum(dssim.*dssim);
   worst_im = worst_im + lamda*(dmse - (sum(dmse.*dssim)/len_dssim)*dssim);
   worst_im = value_constraint(worst_im, im, constraint_range);
   
   ssim_w = ssim2_index(worst_im, im, [0.01 0.03], ones(8));
   dssim = derivative_ssim2(worst_im, im);
   tmp_im = worst_im + lamda2*dssim;
   ssim_t = ssim2_index(tmp_im, im, [0.01 0.03], ones(8));
   lamda2 = lamda2*(FIX_SSIM - ssim_w)/(ssim_t - ssim_w);
   worst_im = worst_im + lamda2*dssim;

	mse = mean2((worst_im - im).^2);
   ssim = ssim2_index(worst_im, im, [0.01 0.03], ones(8));
   [i/10000 mse/10000 ssim]
end

mse1 = mean2((best_im - im).^2);
ssim1 = ssim2_index(best_im, im, [0.01 0.03], ones(8));
[mse1/10000 ssim1 mse/10000 ssim]

figure(21);
subplot(3,3,4), showim(best_im, [0,255], 1);
subplot(3,3,6), showim(worst_im, [0,255], 1);

bdim = best_im - im;
wdim = worst_im - im;
figure(22);
subplot(3,3,4), showim(128 + bdim,[0,255],1);
subplot(3,3,6), showim(128 + wdim,[0,255],1);

[ssim bmap] = ssim2_index(best_im, im, [0.01 0.03], ones(8));
[ssim wmap] = ssim2_index(worst_im, im, [0.01 0.03], ones(8));
figure(23);
subplot(3,3,4), showim(bmap.^2,[0,1],1);
subplot(3,3,6), showim(wmap.^2,[0,1],1);
