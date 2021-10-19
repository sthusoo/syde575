noise = imread('frequnoisy.tif');

figure;
imshow(noise);
title('Frequnoisy image');

ft_noise = log(fftshift(abs(fft2(noise))));

figure;
imshow(ft_noise, []);
title('Fourier spectra of Frequnoisy image');