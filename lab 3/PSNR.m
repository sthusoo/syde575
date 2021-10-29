%% PSNR
function PSNR_out = PSNR(f, g)
    PSNR_out = 10*log10(1/mean2((f-g).^2));
end