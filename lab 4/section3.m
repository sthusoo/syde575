%% SYDE575 - LAB 4 - SECTION 3
%  Adaptive Filtering

%% Estimating Variance Of Noise
%  Loading image and adjusting intensities
degraded = im2double(imread('degraded.tif'));

%  Capturing flat region of the image
figure;
imshow(degraded);
title('Degraded Original');
rectangle = getrect;
degradedFlat = degraded(rectangle(1):rectangle(1)+rectangle(3), rectangle(2):rectangle(2)+rectangle(4));

%  Estimating variance of noise
degradedVariance = var(degradedFlat(:));

%% Lee Filter
localMean = colfilt(degraded, [5,5], 'sliding', @mean);
localVar = colfilt(degraded, [5,5], 'sliding', @var);

%  Denoise image using Lee formulation 
K = zeros(256, 256);
lee = zeros(256, 256);

for x = 1:256
    for y = 1:256
        K(x, y) = (localVar(x, y) - degradedVariance) / localVar(x, y);
        lee(x, y) = K(x, y) * degraded(x, y) + (1 - K(x, y)) * localMean(x, y);
    end
end

%  PSNR
leePSNR = PSNR(degraded, lee);

%  Plot
figure;
subplot(1,2,1), imshow(degraded);
title('Degraded Original');
subplot(1,2,2), imshow(lee);
title('Lee Filtered');

%% Gaussian Low Pass Filter (w/ stddev=30)
%  Create Gaussian filter
gaussian = fspecial('gaussian', 256, 30);
gaussian = gaussian ./ max(max(gaussian));

%  Applying filter
gaussianFiltered = ifft2(ifftshift(fftshift(fft2(degraded)) .* gaussian));

%  PSNR
gaussianPSNR = PSNR(degraded, gaussianFiltered);

%  Plot
figure;
subplot(1,2,1), imshow(lee);
title('Lee Filtered');
subplot(1,2,2), imshow(gaussianFiltered);
title('Gaussian Filtered');

%% Estimate noise variance (above and below)
%  Higher variance
highVar = 0.02;

%  Denoise image using Lee formulation 
KHigh = zeros(256, 256);
leeHigh = zeros(256, 256);

for x = 1:256
    for y = 1:256
        KHigh(x, y) = (localVar(x, y) - highVar) / localVar(x, y);
        leeHigh(x, y) = KHigh(x, y) * degraded(x, y) + (1 - KHigh(x, y)) * localMean(x, y);
    end
end

%  PSNR
leeHighPSNR = PSNR(degraded, leeHigh);

%  Plot
figure;
subplot(1,2,1), imshow(degraded);
title('Degraded Original');
subplot(1,2,2), imshow(leeHigh);
title('Lee Filtered w/ 0.02 Noise Variance');

%  Lower Variance
lowVar = 0;

%  Denoise image using Lee formulation 
KLow = zeros(256, 256);
leeLow = zeros(256, 256);

for x = 1:256
    for y = 1:256
        KLow(x, y) = (localVar(x, y) - lowVar) / localVar(x, y);
        leeLow(x, y) = KLow(x, y) * degraded(x, y) + (1 - KLow(x, y)) * localMean(x, y);
    end
end

%  PSNR
leeLowPSNR = PSNR(degraded, leeLow);

%  Plot
figure;
subplot(1,2,1), imshow(degraded);
title('Degraded Original');
subplot(1,2,2), imshow(leeLow);
title('Lee Filtered w/ 0 Noise Variance');

%% Change size of filter neighborhood (smaller and larger)
%  Smaller Filter
localMeanSmall = colfilt(degraded, [4,4], 'sliding', @mean);
localVarSmall = colfilt(degraded, [4,4], 'sliding', @var);

%  Denoise image using Lee formulation 
KSmall = zeros(256, 256);
leeSmall = zeros(256, 256);

for x = 1:256
    for y = 1:256
        KSmall(x, y) = (localVarSmall(x, y) - degradedVariance) / localVarSmall(x, y);
        leeSmall(x, y) = KSmall(x, y) * degraded(x, y) + (1 - KSmall(x, y)) * localMeanSmall(x, y);
    end
end

%  PSNR
leeSmallPSNR = PSNR(degraded, leeSmall);

%  Plot
figure;
subplot(1,2,1), imshow(degraded);
title('Degraded Original');
subplot(1,2,2), imshow(leeSmall);
title('Lee Filtered w/ Smaller Filter (4x4)');

%  Larger Filter
localMeanLarge = colfilt(degraded, [10,10], 'sliding', @mean);
localVarLarge = colfilt(degraded, [10,10], 'sliding', @var);

%  Denoise image using Lee formulation 
KLarge = zeros(256, 256);
leeLarge = zeros(256, 256);

for x = 1:256
    for y = 1:256
        KLarge(x, y) = (localVarLarge(x, y) - degradedVariance) / localVarLarge(x, y);
        leeLarge(x, y) = KLarge(x, y) * degraded(x, y) + (1 - KLarge(x, y)) * localMeanLarge(x, y);
    end
end

%  PSNR
leeLargePSNR = PSNR(degraded, leeLarge);

%  Plot
figure;
subplot(1,2,1), imshow(degraded);
title('Degraded Original');
subplot(1,2,2), imshow(leeLarge);
title('Lee Filtered w/ Larger Filter (10x10)');