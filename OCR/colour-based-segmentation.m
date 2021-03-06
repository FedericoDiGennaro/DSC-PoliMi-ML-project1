% Read and show image
image = imread('scan.png');
figure()
imshow(image);

% Convert image from RGB color space to L*a*b* color space
% The L*a*b* space consists of a luminosity layer 'L*', chromaticity-layer 'a*' indicating where color falls along the red-green axis,
% and chromaticity-layer 'b*' indicating where the color falls along the blue-yellow axis
lab = rgb2lab(image); ab = lab(:,:,2:3); % For our purposes, we ignore L 
ab = im2single(ab); % Convert to data type 'single' necessary to compute imsegkmeans

% Choose number of clusters
nColors = 2;

% Perform K-means clustering
pixel_labels = imsegkmeans(ab,nColors);

% Show processed image
mask2 = pixel_labels==2; % cluster 2 with red errors
cluster2 = image .* uint8(mask2);
figure()
imshow(cluster2)
