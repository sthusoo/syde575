%% Section 4 - Noise Reduction in the Spatial Domain %%

% Load the Lena image and convert it to a grayscale image using the rgb2gray function
lena_image = imread("lena.tiff");
lena_grayscale = rgb2gray(lena_image);

% To get the intensity of the image within the range of 0 to 1, use the
% double function on the image and then divide it by 255 (alternatively use im2double function)
lena_normalized = im2double(lena_grayscale);
 
figure;
subplot(1,2,1), imshow(lena_normalized);
title('Normalized Lena');
subplot(1,2,2), imhist(lena_normalized);
title('Histogram of Normalized Lena');

% Contaminate the Lena image with zero-mean Gaussian noise with a variance of 0.002
lena_contaminated = imnoise(lena_normalized, 'gaussian', 0, 0.002);

% Plot the noisy image and the corresponding histogram and PSNR between the
% noisy image and the original noise-free image
figure;
subplot(1,2,1), imshow(lena_contaminated);
title('Gaussian Noise Lena');
subplot(1,2,2), imhist(lena_contaminated);
title('Histogram of Gaussian Noise Lena');

lena_contaminated_psnr = 10*log10(1/mean2((lena_normalized-lena_contaminated).^2));

% Create a 3x3 averaging filter kernel using the fspecial function. Plot this filter using imagesc and colormap (gray)
averaging_filter = fspecial('average');

figure;
imagesc(averaging_filter);
colormap('gray');
title('3x3 Averaging Filter');

% Apply the averaging filter to the noisy image using the imfilter function
lena_filter = imfilter(lena_contaminated, averaging_filter);

% Plot the noisy image and the corresponding histogram and PSNR between the
% noisy image and the original noise-free image
figure;
subplot(1,2,1), imshow(lena_filter);
title('3x3 Averaging Filtered Lena');
subplot(1,2,2), imhist(lena_filter);
title('Histogram of 3x3 Averaging Filtered Lena');

lena_filter_psnr = 10*log10(1/mean2((lena_normalized-lena_filter).^2));

% Now create a 7x7 averaging filter kernel and apply it to the noisy image.  
averaging_filter_2 = fspecial('average', 7);
lena_filter_2 = imfilter(lena_contaminated, averaging_filter_2);

% Plot the denoised image and the corresponding histogram. 
figure;
subplot(1,2,1), imshow(lena_filter_2);
title('7x7 Averaging Filtered Lena');
subplot(1,2,2), imhist(lena_filter_2);
title('Histogram of 7x7 Averaging Filtered Lena');

% Also, compute the PSNR between the denoised image and the original noise-free image.
lena_filter_psnr_2 = 10*log10(1/mean2((lena_normalized-lena_filter_2).^2));
% 
% Create a 7x7 Gaussian filter kernel with a standard deviation of 1. Plot the filter.
averaging_filter_3 = fspecial('gaussian', 7, 1);

figure;
imagesc(averaging_filter_3);
colormap('gray');
title('7x7 Gaussian Filter');

% Plot the denoised image and the corresponding histogram. 
lena_filter_3 = imfilter(lena_normalized, averaging_filter_3);

figure;
subplot(2,1,1), imshow(lena_filter_3);
title('7x7 Gaussian Filtered Lena');
subplot(2,1,2), imhist(lena_filter_3);
title('Histogram of 7x7 Gaussian Filtered Lena');

% Compute the PSNR between the denoised imageand the original noise-free
% image
lena_filter_psnr_3 = 10*log10(1/mean2((lena_normalized-lena_filter_3).^2));
% 
% Create a new noisy image by adding salt and pepper noise (density 0.05) to the image.  
lena_noise = imnoise(lena_normalized, 'salt & pepper', 0.05);
lena_salt_pepper_psnr = 10*log10(1/mean2((lena_normalized-lena_noise).^2)); % PSNR Value for reference

% Apply the 7x7 averaging filter and the Gaussian filter to the noisy image separately.  
lena_filter_4 = imfilter(lena_noise, averaging_filter_2);
lena_filter_5 = imfilter(lena_noise, averaging_filter_3);

% Plot the noisy image, the denoised images using each method, and the corresponding histograms.
figure;
subplot(2,1,1), imshow(lena_noise);
title('Noisy Image');
subplot(2,1,2), imhist(lena_noise);
title('Histogram of Noisy Image');

% Denoised Images
figure;
subplot(2,2,1), imshow(lena_filter_4);
title('7x7 Averaging Filter on Salt & Pepper Noise');
subplot(2,2,2), imhist(lena_filter_4);
title('Histogram of 7x7 Averaging Filter on Salt & Pepper Noise');

subplot(2,2,3), imshow(lena_filter_5);
title('7x7 Gaussian Filter on Salt & Pepper Noise');
subplot(2,2,4), imhist(lena_filter_5);
title('Histogram of 7x7 Gaussian Filter on Salt & Pepper Noise');

% Also, compute the PSNR between the denoised images and the original noise-free image
lena_filter_psnr_4 = 10*log10(1/mean2((lena_normalized-lena_filter_4).^2));
lena_filter_psnr_5 = 10*log10(1/mean2((lena_normalized-lena_filter_5).^2));

% Apply the median filter on the noisy image. The medfilt2 function will come in handy for this.
lena_filter_6 = medfilt2(lena_normalized);

% Plot the denoised image and the corresponding histogram.  
figure;
subplot(2,1,1), imshow(lena_filter_6);
title('Median Filtered Lena Image');
subplot(2,1,2), imhist(lena_filter_6);
title('Histogram of Median Filtered Lena Image');

% Also, compute the PSNR between the denoisedimage and the original
% noise-free image
lena_filter_psnr_6 = 10*log10(1/mean2((lena_normalized-lena_filter_6).^2));
