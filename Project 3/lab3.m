% IMAGE ANALYSIS AND COMPUTER VISION: LAB3 CODE BY SERKAN ARDA YILAL
%% Q2 L values for Convergence

%Parameters for filtering and segmentation are defined
K = 6;               % number of clusters used
L = [20 24 28 32];              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

%Segmentation trials on orange for different L values
I_orange = imread('orange.jpg');
I_orange = imresize(I_orange, scale_factor);
I_orangeback = I_orange;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_orange = imfilter(I_orange, h);

%Comparison of different iteration values in plot for orange
figure(1);
t1 = sgtitle("L values for Orange when K = " + K);
t1.FontSize = 25;
for l = 1:length(L)
    I_orange = imread('orange.jpg');
    I_orange = imresize(I_orange, scale_factor);
    I_orangeback = I_orange;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_orange = imfilter(I_orange, h);
    [ segm, centers ] = kmeans_segm(I_orange, K, L(l), seed);
    I_orangenew = mean_segments(I_orangeback, segm);
    I_orange = overlay_bounds(I_orangeback, segm);
    subplot(2,4,l);
    imshow(I_orangenew);
    title("Segments with L = " + L(l),'FontSize', 15);
    subplot(2,4,l + length(L));
    imshow(I_orange);
    title("Bounds with L = " + L(l),'FontSize', 15);
end
%Segmentation trials on tiger1 for different L values


%Comparison of different iteration values in plot for tiger1
figure(2);
t1 = sgtitle("L values for tiger1 when K = " + K);
t1.FontSize = 25;
for l = 1:length(L)
    I_tiger1 = imread('tiger1.jpg');
    I_tiger1 = imresize(I_tiger1, scale_factor);
    I_tiger1back = I_tiger1;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_tiger1 = imfilter(I_tiger1, h);
    [ segm, centers ] = kmeans_segm(I_tiger1, K, L(l), seed);
    I_tiger1new = mean_segments(I_tiger1back, segm);
    I_tiger1 = overlay_bounds(I_tiger1back, segm);
    subplot(2,4,l);
    imshow(I_tiger1new);
    title("Segments with L = " + L(l),'FontSize', 15);
    subplot(2,4,l + length(L));
    imshow(I_tiger1);
    title("Bounds with L = " + L(l),'FontSize', 15);
end

%% Q3 Min K for no superpixel covering both orange halves
%Parameters for filtering and segmentation are defined
K = [6 7 8];               % number of clusters used
L = 50;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

%Segmentation trials on orange for different K values
I_orange = imread('orange.jpg');
I_orange = imresize(I_orange, scale_factor);
I_orangeback = I_orange;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_orange = imfilter(I_orange, h);

%Comparison of different number of clusters in plot for orange
figure(1);
t1 = sgtitle("K values for Orange when L = " + L);
t1.FontSize = 25;
for k = 1:length(K)
    I_orange = imread('orange.jpg');
    I_orange = imresize(I_orange, scale_factor);
    I_orangeback = I_orange;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_orange = imfilter(I_orange, h);
    [ segm, centers ] = kmeans_segm(I_orange, K(k), L, seed);
    I_orangenew = mean_segments(I_orangeback, segm);
    I_orange = overlay_bounds(I_orangeback, segm);
    subplot(2,3,k);
    imshow(I_orangenew);
    title("Segments with K = " + K(k),'FontSize', 15);
    subplot(2,3,k + length(K));
    imshow(I_orange);
    title("Bounds with K = " + K(k),'FontSize', 15);
end

%% Q4 Tiger testing


%Parameters for filtering and segmentation are defined
K_test = [6 7 8];               % number of clusters in array used for different values
K = 6;                       %number of clusters as constant
L_test = [15 20 30 40 50]; % number of iterations in array used for different values
L = 50;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma_test = [1.0 2.0 3.0 4.0 5.0]; % image preblurring scale in array used for different values
image_sigma = 1.0;   % image preblurring scale


% CHECKING FOR DIFFERENT L VALUES
I_tiger1 = imread('tiger1.jpg');
I_tiger1 = imresize(I_tiger1, scale_factor);
I_tiger1back = I_tiger1;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_tiger1 = imfilter(I_tiger1, h);

figure(1);
t1 = sgtitle("L values for tiger1 when K = " + K);
t1.FontSize = 25;
for l = 1:length(L_test)
    I_tiger1 = imread('tiger1.jpg');
    I_tiger1 = imresize(I_tiger1, scale_factor);
    I_tiger1back = I_tiger1;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_tiger1 = imfilter(I_tiger1, h);
    [ segm, centers ] = kmeans_segm(I_tiger1, K, L_test(l), seed);
    I_tiger1new = mean_segments(I_tiger1back, segm);
    I_tiger1 = overlay_bounds(I_tiger1back, segm);
    subplot(2,5,l);
    imshow(I_tiger1new);
    title("Segments with L = " + L_test(l),'FontSize', 15);
    subplot(2,5,l + length(L_test));
    imshow(I_tiger1);
    title("Bounds with L = " + L_test(l),'FontSize', 15);
end

% CHECKING FOR DIFFERENT K VALUES

figure(2);
t1 = sgtitle("K values for tiger1 when L = " + L);
t1.FontSize = 25;
for k = 1:length(K_test)
    I_tiger1 = imread('tiger1.jpg');
    I_tiger1 = imresize(I_tiger1, scale_factor);
    I_tiger1back = I_tiger1;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_tiger1 = imfilter(I_tiger1, h);
    [ segm, centers ] = kmeans_segm(I_tiger1, K_test(k), L, seed);
    I_tiger1new = mean_segments(I_tiger1back, segm);
    I_tiger1 = overlay_bounds(I_tiger1back, segm);
    subplot(2,3,k);
    imshow(I_tiger1new);
    title("Segments with K = " + K_test(k),'FontSize', 15);
    subplot(2,3,k + length(K_test));
    imshow(I_tiger1);
    title("Bounds with K = " + K_test(k),'FontSize', 15);
end

% CHECKING FOR DIFFERENT SIGMA VALUES

figure(3);
t1 = sgtitle("Sigma values for tiger1 when K = " + K + " and L = " +L);
t1.FontSize = 25;
for s = 1:length(image_sigma_test)
    I_tiger1 = imread('tiger1.jpg');
    I_tiger1 = imresize(I_tiger1, scale_factor);
    I_tiger1back = I_tiger1;
    d = 2*ceil(image_sigma_test(s)*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma_test(s));
    I_tiger1 = imfilter(I_tiger1, h);
    
    [ segm, centers ] = kmeans_segm(I_tiger1, K, L, seed);
    I_tiger1new = mean_segments(I_tiger1back, segm);
    I_tiger1 = overlay_bounds(I_tiger1back, segm);
    subplot(2,5,s);
    imshow(I_tiger1new);
    title("Segments with sigma = " + image_sigma_test(s),'FontSize', 15);
    subplot(2,5,s + length(image_sigma_test));
    imshow(I_tiger1);
    title("Bounds with sigma = " + image_sigma_test(s),'FontSize', 15);
end

%% Q5 Changes depending on spatial and color bandwidth
scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = 10.0;  % spatial bandwidth
colour_bandwidth = 20;   % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

spatial_bandwidth_test = [6.0 8.0 10.0 12.0];
color_bandwidth_test = [5.0 10.0 15.0 20.0];




% CHECKING FOR DIFFERENT SPATIAL BANDWIDTHS
figure(1);
t1 = sgtitle("S-BW values for C-BW = " + colour_bandwidth);
t1.FontSize = 25;
for s = 1:length(spatial_bandwidth_test)
    I_tiger1 = imread('tiger1.jpg');
    I_tiger1 = imresize(I_tiger1, scale_factor);
    I_tiger1back = I_tiger1;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_tiger1 = imfilter(I_tiger1, h);
    segm = mean_shift_segm(I_tiger1, spatial_bandwidth_test(s), colour_bandwidth, num_iterations);
    I_tiger1new = mean_segments(I_tiger1back, segm);
    I_tiger1 = overlay_bounds(I_tiger1back, segm);
    subplot(2,4,s);
    imshow(I_tiger1new);
    title("Segments with S-BW = " + spatial_bandwidth_test(s),'FontSize', 15);
    subplot(2,4,s + length(spatial_bandwidth_test));
    imshow(I_tiger1);
    title("Bounds with S-BW = " + spatial_bandwidth_test(s),'FontSize', 15);
end

% CHECKING FOR DIFFERENT COLOR BANDWIDTHS
figure(2);
t1 = sgtitle("C-BW values for S-BW = " + spatial_bandwidth);
t1.FontSize = 25;
for c = 1:length(color_bandwidth_test)
    I_tiger1 = imread('tiger1.jpg');
    I_tiger1 = imresize(I_tiger1, scale_factor);
    I_tiger1back = I_tiger1;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_tiger1 = imfilter(I_tiger1, h);
    segm = mean_shift_segm(I_tiger1, spatial_bandwidth, color_bandwidth_test(c), num_iterations);
    I_tiger1new = mean_segments(I_tiger1back, segm);
    I_tiger1 = overlay_bounds(I_tiger1back, segm);
    subplot(2,4,c);
    imshow(I_tiger1new);
    title("Segments with C-BW = " + color_bandwidth_test(c),'FontSize', 15);
    subplot(2,4,c + length(color_bandwidth_test));
    imshow(I_tiger1);
    title("Bounds with C-BW = " + color_bandwidth_test(c),'FontSize', 15);
end

% Displaying images with suitable bandwidths
%TIGER1

I_tiger1 = imread('tiger1.jpg');
I_tiger1 = imresize(I_tiger1, scale_factor);
I_tiger1back = I_tiger1;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_tiger1 = imfilter(I_tiger1, h);

figure(3);
t1 = sgtitle("Tiger1 with suitable BWs" );
t1.FontSize = 25;
segm = mean_shift_segm(I_tiger1, 8, 10, num_iterations);
I_tiger1new = mean_segments(I_tiger1back, segm);
I_tiger1 = overlay_bounds(I_tiger1back, segm);
subplot(1,2,1);
imshow(I_tiger1new);
title("Segments with C-BW = 8 for S-BW = 10 " ,'FontSize', 15);
subplot(1,2,2);
imshow(I_tiger1);
title("Bounds with C-BW = 8 for S-BW = 10 " ,'FontSize', 15);


% TIGER2
I_tiger2 = imread('tiger2.jpg');
I_tiger2 = imresize(I_tiger2, scale_factor);
I_tiger2back = I_tiger2;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_tiger2 = imfilter(I_tiger2, h);

figure(4);
t1 = sgtitle("Tiger2 with suitable BWs" );
t1.FontSize = 25;
segm = mean_shift_segm(I_tiger2, 6, 8, num_iterations);
I_tiger2new = mean_segments(I_tiger2back, segm);
I_tiger2 = overlay_bounds(I_tiger2back, segm);
subplot(1,2,1);
imshow(I_tiger2new);
title("Segments with C-BW = 6 for S-BW = 8 " ,'FontSize', 15);
subplot(1,2,2);
imshow(I_tiger2);
title("Bounds with C-BW = 6 for S-BW = 8 " ,'FontSize', 15);

% TIGER3
I_tiger3 = imread('tiger3.jpg');
I_tiger3 = imresize(I_tiger3, scale_factor);
I_tiger3back = I_tiger3;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I_tiger3 = imfilter(I_tiger3, h);

figure(5);
t1 = sgtitle("Tiger3 with suitable BWs" );
t1.FontSize = 25;
segm = mean_shift_segm(I_tiger3, 5, 8, num_iterations);
I_tiger3new = mean_segments(I_tiger3back, segm);
I_tiger3 = overlay_bounds(I_tiger3back, segm);
subplot(1,2,1);
imshow(I_tiger3new);
title("Segments with C-BW = 5 for S-BW = 8 " ,'FontSize', 15);
subplot(1,2,2);
imshow(I_tiger3);
title("Bounds with C-BW = 5 for S-BW = 8 " ,'FontSize', 15);

%% Q7 Q8 Q9 Q10 solution is in norm_cuts_example
%% Q11 Q12 Q13 are answered in graphcut_example