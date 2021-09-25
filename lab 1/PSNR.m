%% Section 2 - Image Quality Measures
% Create a new function PSNR that, given a reference image f and a test image
% g as inputs, outputs the PSNR value PSNRout. 

function PSNR_out = PSNR(f, g)
    % f - Reference Image
    % g - Test image
    
    MAX_f = 255; % Assume that MAXf= 255 since using 8-bit data
    
    % Get size of reference image f 
    m = size(f, 1); % num of rows
    n = size(f, 2); % num of cols
   
    squared_diff = (double(f) - double(g)).^2; % convert to double so image is not read as integer
    
    % Calculate Mean Squared Error 
    MSE = (1/(m*n)) * sum(squared_diff(:));
    
    % Calculate Peak Signal to Noise Ratio
    PSNR_out = 10 * log10(MAX_f^2 / MSE);
    
end