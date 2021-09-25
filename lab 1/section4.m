%% Section 4 - Point Operations for Image Enhancement

% Plot the tire image and the histogram using imhist
tire_image = imread("tire.tif");

figure;
subplot(1,2,1), imshow(tire_image);
title('Tire Image');
subplot(1,2,2), imhist(tire_image);
title('Tire Image Histogram')

% Apply image nagtive transform on the image. Plot image and histogram
neg_tire = 255 - tire_image; % Using 255 as max because 8-bit data

figure;
subplot(1,2,1), imshow(neg_tire);
title('Negative Tranformation of Tire Image');
subplot(1,2,2), imhist(neg_tire);
title('Negative Transformation Tire Histogram');

% Apply 2 power-law transformations
% Normalize tire image and convert to double so it isn't read as int
tire_image_norm = double(tire_image)/255;

% γ = 0.5
gamma_1 = 0.5;
tire_power_1 = tire_image_norm.^gamma_1;
% γ = 1.3
gamma_2 = 1.3;
tire_power_2 = tire_image_norm.^gamma_2;

% Plot two transformed images and histograms
figure;
subplot(2,2,1), imshow(tire_power_1);
title('Power Transformation on Tire Image (gamma = 0.5)');
subplot(2,2,2), imhist(tire_power_1);
title('Histogram - Power Transformation on Tire (gamma = 0.5)');
subplot(2,2,3), imshow(tire_power_2);
title('Power Transformation on Tire Image (gamma = 1.3)');
subplot(2,2,4), imhist(tire_power_2);
title('Histogram - Power Transformation on Tire (gamma = 1.3)');

% Perform Histogram Equalization on tire image using histeq 
tire_equalization = histeq(tire_image);

% Plot equalized image and its histogram
figure;
subplot(1,2,1), imshow(tire_equalization);
title('Equalized Tire Image');
subplot(1,2,2), imhist(tire_equalization);
title('Histogram - Equalized Tire Image');
