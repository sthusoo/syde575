% create 256 x 256 test image (white rectangle)
f = zeros(256, 256);
f(:, 108:148) = 1;

% Fourier Spectra of test image
f_fs = fftshift(abs(fft2(f)));

% Plot the images
figure;
subplot(2,1,1), imshow(f);
title('Test Image');
subplot(2,1,2), imshow(f_fs, []);
title('Fourier Spectra of Test Image');

% Rotate test image by 45 degrees
f_rotated = imrotate(f, 45);
f_fs_rotated = fftshift(abs(fft2(f_rotated)));

% Plot the images
figure;
subplot(2,1,1), imshow(f_rotated);
title('Test Image');
subplot(2,1,2), imshow(f_fs_rotated, []);
title('Fourier Spectra of Test Image');

% Load lena and convert to grayscale
lena = imread('lena.tiff');
lena_grayscale = rgb2gray(lena);

% Compute amplitude and phase
lena_amplitude = abs(fftshift(fft2(lena_grayscale)));
lena_phase = fftshift(fft2(lena_grayscale)) ./ lena_amplitude;

% Perform inverse Fourier Transform on Amplitude and Phase
lena_amplitude_inv = ifft2(lena_amplitude);
lena_phase_inv = ifft2(lena_phase);

% Plot of Original Image
figure;
subplot(1,3,1), imshow(lena_grayscale);
title('Original Lena Image');

% Plot of Image Reconstructed with Amplitude
subplot(1,3,2), imshow(lena_amplitude_inv, []);
title('Lena Image Reconstructed with Amplitude');

% Plot of Image Reconstructed with Phase
subplot(1,3,3), imshow(lena_phase_inv, []);
title('Lena Image Reconstructed with Phase');


