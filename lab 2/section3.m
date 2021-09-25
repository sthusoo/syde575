%% Section 3 - Noise Generation %% 

lena_image = imread("lena.tiff");
cameraman_image = imread("cameraman.tif");

f = [0.3*ones(200,100) 0.7*ones(200,100)];

% Noise models
f1 = imnoise(f, 'gaussian', 0, 0.1);
f2 = imnoise(f, 'salt & pepper', 0.05);
f3 = imnoise(f, 'speckle', 0.04);

% Plot the noise-contaminated images and the corresponding histograms for
% each of the noise models
figure;
subplot(3,2,1), imshow(f1);
title('Gaussian Model Toy Image');
subplot(3,2,2), imhist(f1);
title('Histogram of Gaussian Model Toy Image');
subplot(3,2,3), imshow(f2);
title('Salt & Pepper Model Toy Image');
subplot(3,2,4), imhist(f2);
title('Histogram of Salt & Pepper Model Toy Image');
subplot(3,2,5), imshow(f2);
title('Speckle Model Toy Image');
subplot(3,2,6), imhist(f2);
title('Histogram of Speckle Model Toy Image');
