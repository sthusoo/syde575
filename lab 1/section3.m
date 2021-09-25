%% Section 3 - Digital Zooming

% Load lena and Cameraman Images and convert Lena to Grayscale using rgb2gray
% function (Cameraman is already a grayscale image)

lena_image = imread("lena.tiff");
cameraman_image = imread("cameraman.tif");

lena_grayscale = rgb2gray(lena_image);

% Reduce resolution of images by factor of 4 in horizontal & vertical
% directions using bilinear interpolation
lena_reduced = imresize(lena_grayscale, 0.25, 'bilinear');
cameraman_reduced = imresize(cameraman_image, 0.25, 'bilinear');

% Plot downsampled images
figure;
subplot(1,2,1), imshow(lena_reduced);
title('Image 1: Reduced Lena');
subplot(1,2,2), imshow(cameraman_reduced);
title('Image 2: Reduced Cameraman');

% Perform digital zooming to increase resolution of downsampled images back
% to resolution of original images (with a factor of 4):

% 1. Using Nearest Neighbour Interpolation
lena_nn = imresize(lena_reduced, 4, 'nearest');
cameraman_nn = imresize(cameraman_reduced, 4, 'nearest');

% 2. Using Bilinear Interpolation
lena_bilinear = imresize(lena_reduced, 4, 'bilinear');
cameraman_bilinear = imresize(cameraman_reduced, 4, 'bilinear');

% 3. Using Bicubic Interpolation
lena_bicubic = imresize(lena_reduced, 4, 'bicubic');
cameraman_bicubic = imresize(cameraman_reduced, 4, 'bicubic');

% Plot the upsampled images
figure;
subplot(3,3,1), imshow(lena_nn);
title('Subplot 1: Nearest Neighbour - Lena');
subplot(3,3,2), imshow(lena_bilinear);
title('Subplot 2: Bilinear Interpolation - Lena');
subplot(3,3,3), imshow(lena_bicubic);
title('Subplot 3: Bicubic Interpolation- Lena');

subplot(3,3,4), imshow(cameraman_nn);
title('Subplot 4: Nearest Neighbour - Cameraman');
subplot(3,3,5), imshow(cameraman_bilinear);
title('Subplot 5: Bilinear Interpolation - Cameraman');
subplot(3,3,6), imshow(cameraman_bicubic);
title('Subplot 6: Bicubic Interpolation - Cameraman');

% Compute PSNR between original images and each of the upsampled images
% 1. Nearest Neighbours
lena_nn_psnr = PSNR(lena_grayscale, lena_nn);
cameraman_nn_psnr = PSNR(cameraman_image, cameraman_nn);

% 2. Bilinear Interpolation
lena_bilinear_psnr = PSNR(lena_grayscale, lena_bilinear);
cameraman_bilinear_psnr = PSNR(cameraman_image, cameraman_bilinear);

% 3. Bicubic Interpolation
lena_bicubic_psnr = PSNR(lena_grayscale, lena_bicubic);
cameraman_bicubic_psnr = PSNR(cameraman_image, cameraman_bicubic);
