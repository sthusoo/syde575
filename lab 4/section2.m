% Load the Camerman image (adjust intensities to range of 0  to 1)
% Create a disk blur functionof radius of 4 and apply it to the image in
% the frequency domain
h_d = fspecial('disk', 4);
h = zeros(256, 256);
h(1:9, 1:9) = h_d;
h = circshift(h, [-5,-5]);

f = im2double(imread('cameraman.tif'));

h_freq = fft2(h);
f_blur = real(ifft2(h_freq.*fft2(f)));

PSNR_blur = 10*log10(1/mean2((f-f_blur).^2));
inverse_f = real(ifft2( fft2(f_blur) ./ h_freq));

figure;
subplot(1,2,1), imshow(f_blur);
title('Blurred Cameraman Image');
subplot(1,2,2), imshow(inverse_f);
title('Inverse Filtered Cameraman Image');

% add zero-mean Gaussian noise with a variance of 0.002 to the blurred
% image
f_noise = imnoise(f_blur, 'gaussian', 0, 0.002);
inverse_gaussian_f = real(ifft2( fft2(f_noise) ./ h_freq));

figure;
subplot(1,3,1), imshow(f);
title('Original Cameraman Image');
subplot(1,3,2), imshow(f_noise);
title('Noisy Cameraman Image');
subplot(1,3,3), imshow(inverse_gaussian_f);
title('Restored Cameraman Image');

PSNR_gaussian = 10*log10(1/mean2((f-inverse_gaussian_f).^2));

% Apply Wiener filtering on the noisy blurred image
var_f = var(f_noise(:));
snr_approx = 0.002 / var_f;
PSF = h;
wnr = deconvwnr(f_noise, PSF);

figure;
subplot(1,2,1), imshow(f);
title('Original Cameraman Image');
subplot(1,2,2), imshow(wnr)
title('Restored Image - Wiener filter')

PSNR_wiener = 10*log10(1/mean2((f-wnr).^2));

