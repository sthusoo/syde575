%% Section 2 - Discrete Convolution for Image Proccessing %%

% Load the Lena image and convert it to a grayscale image using the rgb2gray function
lena_image = imread("lena.tiff");
lena_grayscale = rgb2gray(lena_image);

% To get intensity of the image within the range of 0 to 1, use the double function on the image 
% and then divide it by 255
lena_normalized = double(lena_grayscale)/255;

% Construct three impulse functions h1,h2,h3
h1 = (1/6)*ones(1,6);
h2 = h1';
h3 = [-1,1];

%  Use  the conv2 function  to  convolve  the  Lena  image  with  the
%  impulse  functions h1,h2,h3 separately
h1_conv = conv2(lena_normalized, h1);
h2_conv = conv2(lena_normalized, h2);
h3_conv = conv2(lena_normalized, h3);

% Plot the original image as well as the convolved images
figure;
subplot(2,2,1), imshow(lena_normalized);
title('Image 1: Lena - Normalized');
subplot(2,2,2), imshow(h1_conv);
title('Image 2: Convolution with h1');
subplot(2,2,3), imshow(h2_conv);
title('Image 3: Convolution with h2');
subplot(2,2,4), imshow(h3_conv);
title('Image 4: Convolution with h3');
