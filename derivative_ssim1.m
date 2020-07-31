function dssim = derivative_ssim1(im1, im2)
%derivative of SSIM

window = ones(8);
K(1) = 0.01;
K(2) = 0.03;
L = 255;

C1 = (K(1)*L)^2;
C2 = (K(2)*L)^2;
window = window/sum(sum(window));

mu1   = filter2(window, im1, 'valid');
mu2   = filter2(window, im2, 'valid');
mu1_sq = mu1.*mu1;
mu2_sq = mu2.*mu2;
mu1_mu2 = mu1.*mu2;
sigma1_sq = filter2(window, im1.*im1, 'valid') - mu1_sq;
sigma2_sq = filter2(window, im2.*im2, 'valid') - mu2_sq;
sigma12 = filter2(window, im1.*im2, 'valid') - mu1_mu2;

a1 = 2*mu1_mu2 + C1;
a2 = 2*sigma12 + C2;
b1 = mu1_sq + mu2_sq + C1;
b2 = sigma1_sq + sigma2_sq + C2;

[M1 M2] = size(im1);
[W1 W2] = size(window);
dssim = zeros(M1, M2);
swin = zeros(M1, M2);
for i=1:M1-W1+1
   for j=1:M2-W2+1
      x = im1(i:i+W1-1, j:j+W2-1);
      y = im2(i:i+W1-1, j:j+W2-1);
      A1 = a1(i,j);
      B1 = b1(i,j);
      A2 = a2(i,j);
      B2 = b2(i,j);
      MUx = mu1(i,j);
      MUy = mu2(i,j);
      local_dssim = (2/(W1*W2*B1^2*B2^2)) * (A1*A2*MUx*(B1-B2) + B1*B2*MUy*(A2-A1) + A1*B1*(B2*y - A2*x));
      dssim(i:i+W1-1, j:j+W2-1) = dssim(i:i+W1-1, j:j+W2-1) + local_dssim;
      swin(i:i+W1-1, j:j+W2-1) = swin(i:i+W1-1, j:j+W2-1) + window;
   end
end
swin = swin/max(max(swin));
dssim = dssim./swin;

return