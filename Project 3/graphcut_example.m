scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 16;                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma = 10.0;                % edge cost decay factor

alpha_test = [8.0 12.0];
sigma_test = [10.0 15.0];

I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result/graphcut1.png')
% imwrite(I,'result/graphcut2.png')
% imwrite(prior,'result/graphcut3.png')
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(I);
subplot(2,2,3); imshow(prior);

%% Alpha Testing
scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 16;                      % number of mixture components
alpha_test = [4.0 8.0];     % test values for alpha
sigma = 10.0;                % edge cost decay factor


%looping over different alpha values while keeping other parameters the
%same
figure(1);
t1 = sgtitle("alpha Comparsion with K = " + K + ", sigma = " + sigma + ", area = [" + area(1) + "," +area(2) +"," + area(3) + "," +area(4) + "]" );
t1.FontSize = 20;
for a = 1:length(alpha_test)
    area = [ 80, 110, 570, 300 ];
    I = imread('tiger1.jpg');
    I = imresize(I, scale_factor);
    Iback = I;
    area = int16(area*scale_factor);
    [ segm, prior ] = graphcut_segm(I, area, K, alpha_test(a), sigma);

    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);

    subplot(2,3,a + (a-1)*2);
    imshow(Inew);
    title("Segments with alpha = " + alpha_test(a),'FontSize', 15);
    subplot(2,3,a + 1 + (a-1)*2 );
    imshow(I);
    title("Bounds with alpha = " + alpha_test(a),'FontSize', 15);
    subplot(2,3,a + 2 + (a-1)*2);
    imshow(prior);
    title("Prior Probabilities with alpha = " + alpha_test(a),'FontSize', 15);
end

%% Sigma Testing

scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 16;                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma_test = [5.0 15.0];              % test values for sigma


%looping over different sigma values while keeping other parameters the
%same
figure(1);
t1 = sgtitle("sigma Comparsion with K = " + K + ", alpha = " + alpha + ", area = [" + area(1) + "," +area(2) +"," + area(3) + "," +area(4) + "]" );
t1.FontSize = 20;
for s = 1:length(sigma_test)
    area = [ 80, 110, 570, 300 ];
    I = imread('tiger1.jpg');
    I = imresize(I, scale_factor);
    Iback = I;
    area = int16(area*scale_factor);
    [ segm, prior ] = graphcut_segm(I, area, K, alpha , sigma_test(s));

    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);

    subplot(2,3,s + (s-1)*2);
    imshow(Inew);
    title("Segments with sigma = " + sigma_test(s),'FontSize', 15);
    subplot(2,3,s + 1 + (s-1)*2 );
    imshow(I);
    title("Bounds with sigma = " + sigma_test(s),'FontSize', 15);
    subplot(2,3,s + 2 + (s-1)*2);
    imshow(prior);
    title("Prior Probabilities with sigma = " + sigma_test(s),'FontSize', 15);
end

%% Ideals for tiger1

%ideal parameters for tiger1 image
scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ];  % image region to train foreground with
K = 16;                      % number of mixture components
alpha = 16.0;                 % maximum edge cost
sigma = 10.0;            % edge cost decay factor

figure(1);
t1 = sgtitle("Ideal for tiger1 with K = " + K + ", sigma = " + sigma + ", alpha = " + alpha + ", area = [" + area(1) + "," +area(2) +"," + area(3) + "," +area(4) + "]" );
t1.FontSize = 20;

area = [ 80, 110, 570, 300 ];
I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);

subplot(1,3,1);
imshow(Inew);
title("Segments of tiger1",'FontSize', 15);
subplot(1,3,2 );
imshow(I);
title("Bounds of tiger1",'FontSize', 15);
subplot(1,3,3);
imshow(prior);
title("Prior Probabilities of tiger1 " ,'FontSize', 15);

%% Ideals for tiger2

%ideal parameters for tiger2 image
scale_factor = 0.5;          % image downscale factor
area = [ 130, 150, 250, 180 ]; % image region to train foreground with
K = 16;                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma = 36.0;            % edge cost decay factor

figure(1);
t1 = sgtitle("Ideal for tiger2 with K = " + K + ", sigma = " + sigma + ", alpha = " + alpha + ", area = [" + area(1) + "," +area(2) +"," + area(3) + "," +area(4) + "]" );
t1.FontSize = 20;

area = [ 80, 110, 570, 300 ];
I = imread('tiger2.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);

subplot(1,3,1);
imshow(Inew);
title("Segments of tiger2",'FontSize', 15);
subplot(1,3,2 );
imshow(I);
title("Bounds of tiger2",'FontSize', 15);
subplot(1,3,3);
imshow(prior);
title("Prior Probabilities of tiger2 " ,'FontSize', 15);

%% Ideals for tiger3
%ideal parameters for tiger3 image
scale_factor = 0.5;          % image downscale factor
area = [ 130, 150, 250, 180 ]; % image region to train foreground with
K = 16;                      % number of mixture components
alpha = 16.0;                 % maximum edge cost
sigma = 12.0;            % edge cost decay factor

figure(1);
t1 = sgtitle("Ideal for tiger3 with K = " + K + ", sigma = " + sigma + ", alpha = " + alpha + ", area = [" + area(1) + "," +area(2) +"," + area(3) + "," +area(4) + "]" );
t1.FontSize = 20;

area = [ 80, 110, 570, 300 ];
I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);

subplot(1,3,1);
imshow(Inew);
title("Segments of tiger3",'FontSize', 15);
subplot(1,3,2 );
imshow(I);
title("Bounds of tiger3",'FontSize', 15);
subplot(1,3,3);
imshow(prior);
title("Prior Probabilities of tiger3 " ,'FontSize', 15);