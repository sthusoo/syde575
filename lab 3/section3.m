%% SYDE 575 - LAB 3 - SECTION 3
% Noise Reduction in the Frequency Domain

%% Plot Log Fourier spectra of original and noisy images

% Load Lena Image
lena = im2double(rgb2gray(imread('lena.tiff'))); % intensities -> [0,1]
noisyLena = imnoise(lena, 'gaussian', 0, 0.005); % additive Gaussian noise

% Computing DFT of original and noisy images
lenaDFT = fftshift(fft2(lena));
noisyLenaDFT = fftshift(fft2(noisyLena));

% Computing Log Fourier Spectra
lenaDFTLog = log(abs(lenaDFT));
noisyLenaDFTLog = log(abs(noisyLenaDFT));

% Plotting
figure;
subplot(1,2,1), imshow(lenaDFTLog, []);
title('Lena Log Fourier Spectra');
subplot(1,2,2),imshow(noisyLenaDFTLog, []);
title('Noisy Lena Log Fourier Spectra');

%% Low-pass filter w/ cut-off radius 60
% Creating filter
[rows, columns, numberOfColorChannels] = size(lena);
r_60 = 60;
h_60 = fspecial('disk', r_60);
h_60(h_60>0) = 1;
hFreq_60 = zeros(rows, columns);
hFreq_60([rows/2-r_60:rows/2+r_60],[columns/2-r_60:columns/2+r_60]) = h_60;

% Plotting filter
figure;
imshow(hFreq_60);
title('Low-pass filter w/ cut-off radius 60');

% Applying filter
noisyLenaFiltered_60 = noisyLenaDFT .* hFreq_60;
noisyLenaFilteredInverse_60 = ifft2(ifftshift(noisyLenaFiltered_60));

% Plotting filtered noisy Lena
figure;
subplot(1,3,1), imshow(lena);
title('Original Lena');
subplot(1,3,2),imshow(noisyLena);
title('Noisy Lena');
subplot(1,3,3),imshow(noisyLenaFilteredInverse_60);
title('Noisy Lena w/ Low-pass Filter (r=60)');

% PSNR
psnr_60 = PSNR(lena, abs(noisyLenaFilteredInverse_60));

%% Low-pass filter w/ cut-off radius 20
% Creating filter
r_20 = 20;
h_20 = fspecial('disk', r_20);
h_20(h_20>0) = 1;
hFreq_20 = zeros(rows, columns);
hFreq_20([rows/2-r_20:rows/2+r_20],[columns/2-r_20:columns/2+r_20]) = h_20;

% Applying filter
noisyLenaFiltered_20 = noisyLenaDFT .* hFreq_20;
noisyLenaFilteredInverse_20 = ifft2(ifftshift(noisyLenaFiltered_20));

% Plotting filtered noisy Lena
figure;
subplot(1,3,1), imshow(lena);
title('Original Lena');
subplot(1,3,2),imshow(noisyLena);
title('Noisy Lena');
subplot(1,3,3),imshow(noisyLenaFilteredInverse_20);
title('Noisy Lena w/ Low-pass Filter (r=20)');

% PSNR
psnr_20 = PSNR(lena, abs(noisyLenaFilteredInverse_20));

%% Gaussian low-pass filter w/ stddev 60, normalized on max(kernel val)
% Creating filter
gaussianFilter = fspecial('gaussian', rows, 60);
gaussianFilter = gaussianFilter ./ max(max(gaussianFilter));

% Applying filter
noisyLenaFiltered_g = noisyLenaDFT .* gaussianFilter;
noisyLenaFilteredInverse_g = ifft2(ifftshift(noisyLenaFiltered_g));

% Plotting filtered noisy Lena
figure;
subplot(1,3,1), imshow(lena);
title('Original Lena');
subplot(1,3,2),imshow(noisyLena);
title('Noisy Lena');
subplot(1,3,3),imshow(noisyLenaFilteredInverse_g);
title('Noisy Lena w/ Gaussian Filter)');

% PSNR
psnr_g = PSNR(lena, abs(noisyLenaFilteredInverse_g));