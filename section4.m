%% SYDE 575 - LAB 5 - SECTION 4
%  Image Transform

%% 8x8 DCT Matrix
T = dctmtx(8);
f = double(rgb2gray(imread('lena.tiff')));

figure;
imshow(T);
title('8x8 DCT Transform Matrix');

%% Absolute Value of 8x8 DCT Sub-Images
F_trans = floor(blkproc(f-128,[8 8],'P1*x*P2',T,T'));

figure;
disp(F_trans(81:88,297:304))
imshow(abs(F_trans(81:88,297:304)),[]);
title('Abs Val at (81,297)');

figure;
imshow(abs(F_trans(1:8,1:8)),[]);
title('Abs Val at (1,1)');

%% Original 8x8 DCT Sub-Images
f = im2double(rgb2gray(imread('lena.tiff')));

figure;
imshow(f(81:88,297:304));
title('Original at (81,297)');

figure;
imshow(f(1:8,1:8));
title('Original at (1,1)');

%% Reconstructed Lena
mask = zeros(8,8);
mask(1,1) = 1;
mask(1,2) = 1;
mask(1,3) = 1;
mask(2,1) = 1;
mask(3,1) = 1;
mask(2,2) = 1;
F_thresh = blkproc(F_trans,[8 8],'P1.*x',mask);
f_thresh = floor(blkproc(F_thresh,[8 8],'P1*x*P2',T',T))+128;

figure;
subplot(2,1,1), imshow(f);
title('Original Lena');
subplot(2,1,2), imshow(f_thresh,[]);
title('Reconstructed Lena');

psnr = PSNR(f_thresh/256,f);