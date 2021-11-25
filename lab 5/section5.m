lena = imread('lena.tiff');
f = im2double(rgb2gray(lena));

Z = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
 
T = dctmtx(8);
F_trans = floor(blkproc(f-128,[8 8],'P1*x*P2',T,T'));

for j = [1,3,5,10]
    F_thresh = blkproc(F_trans, [8,8], 'round(x./(P1*j))', Z); %change
    f_thresh = floor(blkproc(F_thresh, [8,8], 'P1* (x.*(P3*j)) *P2', T', T, Z)) + 128; %change
    
    figure;
    imshow(f_thresh, []);
    title(sprintf('Quantized Image with %dZ', j));
end