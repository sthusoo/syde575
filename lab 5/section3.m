peppers = imread('peppers.png');
peppers_lab = applycform(peppers, makecform('srgb2lab'));

ab = double(peppers_lab(:,:,2:3)); % NOT im2double
m = size(ab,1);
n = size(ab,2);
ab = reshape(ab,m*n,2);

% K = 2;
% row = [55 200];
% col = [155 400];
K = 4;
row = [55 130 200 280];
col = [155 110 400 470];

% Convert (r,c) indexing to 1D linear indexing.
idx = sub2ind([size(peppers,1) size(peppers,2)], row, col);
% Vectorize starting coordinates
for k = 1:K
    mu(k,:) = ab(idx(k),:);
end

cluster_idx = kmeans(ab, K, 'start', mu);

% Label each pixel according to k-means
pixel_labels = reshape(cluster_idx, m, n);
h = figure, imshow(pixel_labels, []);
title('Image labeled by cluster index');
colormap('jet')

% Output each cluster/segmented region using the original colours of the image using thepixel
% labels found for k= 4
labels = repmat(pixel_labels, [1,1,3]);
clustered_peppers = peppers;

figure;
for k = 1:K
    clustered_peppers = peppers(:,:,:) .* uint8(labels(:,:,1)== k);
    subplot(2,2,k), imshow(clustered_peppers);
    title(sprintf('Cluster %d', k));
end
    