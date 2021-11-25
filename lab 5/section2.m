% convert the image from the RGB colorspace into the YCbCr colorspace using the rgb2ycbcr function
peppers_rgb = imread('peppers.png');
peppers_ycbcr = rgb2ycbcr(peppers_rgb);

figure;
subplot(1,3,1), imshow(peppers_ycbcr(:,:,1));
title('Channel Y');
subplot(1,3,2), imshow(peppers_ycbcr(:,:,2));
title('Channel Cb');
subplot(1,3,3), imshow(peppers_ycbcr(:,:,2));
title('Channel Cr');

% Now, reduce the resolution of the chroma channels by a factor of 2 in both 
% the horizontal and vertical directions and then upsample them back to the 
% original resolution using bilinear interpolation

cb_upsampled = imresize( imresize(peppers_ycbcr(:,:,2), 0.5), 2, 'bilinear');
cr_upsampled = imresize( imresize(peppers_ycbcr(:,:,3), 0.5), 2, 'bilinear');

% Recombine the original Y channel image and the two upsampledCb and Cr
% images to create a new color image
ycbcr_upsampled = peppers_ycbcr;
ycbcr_upsampled(:,:,2) = cb_upsampled;
ycbcr_upsampled(:,:,3) = cr_upsampled;

recombined = ycbcr2rgb(ycbcr_upsampled);

figure;
subplot(1,2,1), imshow(peppers_rgb);
title('Original Image');
subplot(1,2,2), imshow(recombined);
title('Chroma Channel Resized Image');

% Reduce the resolution of the luma (Y) channel by a factorof 2 in both the 
% horizontal and vertical directions and then upsample it back to the original resolution using bilinear interpolation
upsampled_y = imresize( imresize(peppers_ycbcr(:,:,1), 0.5), 2, 'bilinear');

% Recombine the upsampled Y channel image and the original Cb and Cr images
% to create a new color image
y_resized = peppers_ycbcr;
y_resized(:,:,1) = upsampled_y;

recombined_y = ycbcr2rgb(y_resized);

figure;
subplot(1,2,1), imshow(peppers_rgb);
title('Original Image');
subplot(1,2,2), imshow(recombined_y);
title('Y Resized Image');