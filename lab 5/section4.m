lena = imread('lena.tiff');
f = im2double(rgb2gray(lena));
T = dctmtx(8);

F_trans = floor(blkproc(f-128,[8 8],'P1*x*P2',T,T'));
abs_dct = abs(F_trans(297:304, 81:88));

figure;
imshow(abs_dct); % rescale with []
title('Absolute Value of DCT');

mask = zeros(8,8);
mask(1,1) = 1;
mask(1,2) = 1;
mask(1,3) = 1;
mask(2,1) = 1;
mask(3,1) = 1;
mask(2,2) = 1;
F_thresh = blkproc(F_trans, [8 8], 'P1.*x', mask);

f_thresh = floor(blkproc(F_thresh, [8 8], 'P1*x*P2', T', T)) + 128;

figure;
subplot(1,2,1), imshow(lena);
title('Original Image');
subplot(1,2,2), imshow(f_thresh, []);
title('Reconstructed Image');

PSNR = PSNR(f, f_thresh);