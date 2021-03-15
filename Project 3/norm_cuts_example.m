colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.5;      % cutting threshold
min_area = 10;          % minimum area of segment
max_depth = 8;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale


%Parameters for testing purposes
color_bandwidth_test = [15 20];

ncuts_thresh_test = [0.1 3];

max_depth_test = [5 10];




%NCUTS_THRESHOLD COMPARISON

figure(1);
t1 = sgtitle("ncuts-thresh Comparsion C-BW = " + colour_bandwidth + ", R = " + radius + ", min area = " + min_area + ", max depth = " + max_depth );
t1.FontSize = 20;
for n = 1:length(ncuts_thresh_test)
    I_ncut = imread('tiger1.jpg');
    I_ncut = imresize(I_ncut, scale_factor);
    I_ncutback = I_ncut;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_ncut = imfilter(I_ncut, h);
    segm = norm_cuts_segm(I_ncut, colour_bandwidth, radius, ncuts_thresh_test(n), min_area, max_depth);
    I_ncutnew = mean_segments(I_ncutback, segm);
    I_ncut = overlay_bounds(I_ncutback, segm);
% Looping over different ncuts-thresholds
    subplot(2,2,n);
    imshow(I_ncutnew);
    title("Segments with ncuts-threshold = " + ncuts_thresh_test(n),'FontSize', 15);
    subplot(2,2,n + length(ncuts_thresh_test));
    imshow(I_ncut);
    title("Bounds with ncuts-threshold = " + ncuts_thresh_test(n),'FontSize', 15);
end



%MAX_DEPTH COMPARISON
figure(2);
t1 = sgtitle("max-depth Comparsion C-BW = " + colour_bandwidth + ", R = " + radius + ", min area = " + min_area + ", ncuts-thresh = " + ncuts_thresh );
t1.FontSize = 20;
for m = 1:length(max_depth_test)
    I_maxd = imread('tiger1.jpg');
    I_maxd = imresize(I_maxd, scale_factor);
    I_maxdback = I_maxd;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_maxd = imfilter(I_maxd, h);
    segm = norm_cuts_segm(I_maxd, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth_test(m));
    I_maxdnew = mean_segments(I_maxdback, segm);
    I_maxd = overlay_bounds(I_maxdback, segm);
% Looping over different max-depths
    subplot(2,2,m);
    imshow(I_maxdnew);
    title("Segments with max-depth = " + max_depth_test(m),'FontSize', 15);
    subplot(2,2,m + length(max_depth_test));
    imshow(I_maxd);
    title("Bounds with max-depth = " + max_depth_test(m),'FontSize', 15);
end



%COLOR BANDWIDTH COMPARISON
figure(3);
t1 = sgtitle("C-BW Comparsion max depth = " + max_depth + ", R = " + radius + ", min area = " + min_area + ", ncuts-thresh = " + ncuts_thresh );
t1.FontSize = 20;
for c = 1:length(color_bandwidth_test)
    I_cbw = imread('tiger3.jpg');
    I_cbw = imresize(I_cbw, scale_factor);
    I_cbwback = I_cbw;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_cbw = imfilter(I_cbw, h);
    segm = norm_cuts_segm(I_cbw, color_bandwidth_test(c), radius, ncuts_thresh, min_area, max_depth);
    I_cbwnew = mean_segments(I_cbwback, segm);
    I_cbw = overlay_bounds(I_cbwback, segm);
% Looping over different color-bandwidths
    subplot(2,2,c);
    imshow(I_cbwnew);
    title("Segments with C-BW = " + color_bandwidth_test(c),'FontSize', 15);
    subplot(2,2,c + length(color_bandwidth_test));
    imshow(I_cbw);
    title("Bounds with C-BW = " + color_bandwidth_test(c),'FontSize', 15);
end

%% Radius test
colour_bandwidth = 20.0; % color bandwidth
radius_test = [2 10];% maximum neighbourhood distance
ncuts_thresh = 0.5;      % cutting threshold
min_area = 10;          % minimum area of segment
max_depth = 8;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale


figure(1);
t1 = sgtitle("radius Comparsion C-BW = " + colour_bandwidth + ", ncut-thresh = " + ncuts_thresh + ", min area = " + min_area + ", max depth = " + max_depth );
t1.FontSize = 20;
for r = 1:length(radius_test)
    I_rad = imread('tiger1.jpg');
    I_rad = imresize(I_rad, scale_factor);
    I_radback = I_rad;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I_rad = imfilter(I_rad, h);
    segm = norm_cuts_segm(I_rad, colour_bandwidth, radius_test(r), ncuts_thresh, min_area, max_depth);
    I_radnew = mean_segments(I_radback, segm);
    I_rad = overlay_bounds(I_radback, segm);
% Looping over different radiuses
    subplot(2,2,r);
    imshow(I_radnew);
    title("Segments with radius = " + radius_test(r),'FontSize', 15);
    subplot(2,2,r + length(radius_test));
    imshow(I_rad);
    title("Bounds with radius = " + radius_test(r),'FontSize', 15);
end