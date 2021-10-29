noise = imread('frequnoisy.tif');

% Plot image
figure;
imshow(noise);
title('Frequnoisy image');

% convert to double
noise = im2double(noise);

% Fourier Transform
fourier_noise = fftshift(fft2(noise));
log_fourier_noise = log(abs(fftshift(fft2(noise))));

figure;
imshow(log_fourier_noise, []);
title('Log Fourier spectra of Frequnoisy image');

figure;
imshow(fourier_noise, []);
title('Fourier spectra of Frequnoisy image');

% determine pixel location
imtool(fourier_noise, [])

fourier_noise(65,65) = 0;
fourier_noise(119, 105) = 0;

fourier_noise(139, 153) = 0;
fourier_noise(193, 193) = 0;

inverse_fourier_noise = ifft2(ifftshift(fourier_noise));

figure;
imshow(inverse_fourier_noise, []);
title('Filtered Frequnoisy image');
