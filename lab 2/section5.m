%% Section 5 - Sharpening in the Spatial Domain %%

% Load the Cameraman image and get intensity of the image within the range
% of 0 to 1
cameraman_image = imread("cameraman.tif");
cameraman_normalized = im2double(cameraman_image);

% Apply the 7x7 Gaussian filter on the Cameraman image and subtract the
% Gaussian-filtered image from the original Cameraman image
averaging_filter_2 = fspecial('average', 7);
cameraman_filered = imfilter(cameraman_normalized, averaging_filter_2);

subtracted_image = cameraman_normalized - cameraman_filered;

% Plot both the Gaussian-filtered image and the subtracted image
figure;
subplot(1,2,1), imshow(cameraman_filered);
title('7x7 Averaging Filtered Cameraman');
subplot(1,2,1), imshow(subtracted_image);
title('Subtracted Image');

% Add the subtracted image to the original image. Plot the resulting
% image
sharpened_image = cameraman_normalized + subtracted_image;
figure;
imshow(sharpened_image);
title('Sharpened Image of Cameraman');

% Now, instead of adding the subtracted image to the original image,
% multiply the subtracted image by 0.5 and then add it to the original
% image
sharpened_image_2 = cameraman_normalized + subtracted_image*0.5;

% Plot the resulting image
figure;
imshow(sharpened_image_2);
title('Sharpened Image of Cameraman (Subtracted image multiplied by 0.5)');