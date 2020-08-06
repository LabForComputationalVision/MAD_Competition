% generate SSIM output for comparing to plenoptic

ssim = struct('standard', struct(), 'weighted', struct(), 'base_img', 'samp1.tif');
base_img = imread(['data/images/' ssim.base_img]);
for i=1:10
    imname = ['data/images/samp' num2str(i) '.tif'];
    val = ssim_index(base_img, imread(imname));
    eval(['ssim.standard.samp' num2str(i) ' = ' num2str(val) ';']);
    val = ssim_weighted(base_img, imread(imname));
    eval(['ssim.weighted.samp' num2str(i) ' = ' num2str(val) ';']);
end

save('data/ssim_analysis.mat', '-struct', 'ssim');
