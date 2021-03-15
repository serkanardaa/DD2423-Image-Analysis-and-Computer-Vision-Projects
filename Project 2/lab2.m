% IMAGE ANALYSIS AND COMPUTER VISION: LAB2 CODE BY SERKAN ARDA YILAL
%Q1 %%%%DIFFERENCE OPERATORS
%In this question, we are going to use sobel operator by using sobel
%operator matrixes 
deltax = [-1 0 1; -2 0 2; -1 0 1];
deltay = [-1 -2 -1; 0 0 0; 1 2 1];

%X-wise and Y-wise differentiation of tools image with sobel operators
tools = few256;
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');

figure(1);

%tools image
subplot(1,3,1);
showgrey(tools);
title("Tools",'FontSize', 20);

%X-wise partial derivative of tools
subplot(1,3,2);
showgrey(dxtools);
title("x-wise partial derivative of tools",'FontSize', 20);

%Y-wise partial derivative of tools
subplot(1,3,3);
showgrey(dytools);

title("y-wise partial derivative of tools",'FontSize', 20);

%% Q2 and Q3 %%%%POINTWISE THRESHOLDING OF GRADIENT MAGNITUDES
%Calculation of gradient magnitude of tools and applying different thresholds for achieving thin edges.

%sobel operators, image, and differentiators are applied
deltax = [-1 0 1; -2 0 2; -1 0 1];
deltay = [-1 -2 -1; 0 0 0; 1 2 1];

%X-wise and Y-wise differentiation of tools image with sobel operators
tools = few256;
dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');

%threshold values are defined
threshold = [25 50 75 100 125 150];

%gradient magnitude of tools is calculated
gradmagntools = sqrt(dxtools.^2 + dytools.^2);

%gradient magnitude of tools and its histogram are displayed
figure(1);
subplot(1,2,1);
showgrey(gradmagntools);
title("Gradient Magnitude of Tools",'FontSize', 20);
subplot(1,2,2);
histogram(gradmagntools);
title("Histogram of Gradient Magnitude of Tools",'FontSize', 20);

%Different threshold values are applied and displayed for tools
figure(2);
t1 = sgtitle("Thresholded Gradient Magnitudes of Tools");
t1.FontSize = 25;
%Thresholded gradient magnitude of tools for different threshold values
for t = 1:length(threshold)
    thresholded_magn = (gradmagntools - threshold(t)) > 1;
    subplot(2,3,t);
    showgrey(thresholded_magn);
    title("Thresholded with = " + num2str(threshold(t)),'FontSize', 20);
end

%%%---------------------GODTHEM256
%Gradient magnitude and thresholding applications for image godthem256
%which has a higher complexity

new_threshold = [5 10 15 20 25 30];
%gaussian filter smoothing
variance = 2;
godthem = godthem256;
%godthem with smoothing of gaussian filter
smooth_godthem = gaussfft(godthem,variance); %smoothing of godthem256 with gaussian kernel from previous lab

%Gradient magnitudes of godthem and smoothed godthem
Lv_godthem = Lv(godthem,'valid'); %zero-padding is not considered with valid
Lv_smooth_godthem = Lv(smooth_godthem,"valid"); 

figure(3);
%Gradient magnitude of godthem image
subplot(2,2,1);
showgrey(Lv_godthem);
title("Gradient Magnitude of godthem256",'FontSize', 20);
%Histogram of Gradient magnitude of godthem image
subplot(2,2,2);
histogram(Lv_godthem);
title("Histogram of Gradient Magnitude of godthem256",'FontSize', 20);
%Gradient magnitude of smoothed godthem image
subplot(2,2,3);
showgrey(Lv_smooth_godthem);
title("Gradient Magnitude of smoothed godthem256",'FontSize', 20);
%Histogram of Gradient magnitude of smoothed godthem image
subplot(2,2,4);
histogram(Lv_smooth_godthem);
title("Histogram of Gradient Magnitude of smoothed godthem256",'FontSize', 20);

figure(4);

t2 = sgtitle("Thresholded Gradient Magnitudes of godthem256");
t2.FontSize = 25;
%Thresholded gradient magnitude of godthem256 for different threshold values
for t = 1:length(new_threshold)
    thresholded_magn = (Lv_godthem - new_threshold(t)) > 1;
    subplot(2,3,t);
    showgrey(thresholded_magn);
    title("Thresholded with = " + num2str(new_threshold(t)),'FontSize', 20);
end

figure(5);

t3 = sgtitle("Thresholded Gradient Magnitudes of smoothed godthem256");
t3.FontSize = 25;
%Thresholded gradient magnitude of smoothed godthem256 for different threshold values
for t = 1:length(new_threshold)
    thresholded_magn = (Lv_smooth_godthem - new_threshold(t)) > 1;
    subplot(2,3,t);
    showgrey(thresholded_magn);
    title("Thresholded with = " + num2str(new_threshold(t)),'FontSize', 20);
end

%% Q4 Q5 Q6 %%%% COMPUTING DIFFERENTIAL GEOMETRY DESCRIPTORS
%First Experiment

%We define our image and different values of scale for testing scaling
%effect on the image
house = godthem256;
scale = [0.0001 1 4 16 64];

%Second derivative of house image with different scaling factors with usage
%of gaussian filter
figure(1);
subplot(2,3,1);
showgrey(house);
title("Original Image house",'FontSize', 20);
for i = 1:length(scale)
    subplot(2,3,i+1);
    contour(Lvvtilde(discgaussfft(house, scale(i)), 'same'), [0 0]);
    axis('image');
    axis('ij');
    title("Second order derivative with scale: " + num2str(scale(i)),'FontSize', 20);
end

%Second Experiment
tools = few256;

%Second derivative of tools image with different scaling factors with usage
%of gaussian filter
figure(2);
subplot(2,3,1);
showgrey(tools);
title("Original Image tools",'FontSize', 20);
for i = 1:length(scale)
    subplot(2,3,i+1);
    contour(Lvvtilde(discgaussfft(tools, scale(i)), 'same'), [0 0]);
    axis('image');
    axis('ij');
    title("Second order derivative with scale: " + num2str(scale(i)),'FontSize', 20);
end


%Third derivative of tools image with different scaling factors with usage
%of gaussian filter
figure(3);
subplot(2,3,1);
showgrey(tools);
title("Original Image tools",'FontSize', 20);
for i = 1:length(scale)
    subplot(2,3,i+1);
    showgrey(Lvvvtilde(discgaussfft(tools, scale(i)), 'same') < 0);
    axis('image');
    axis('ij');
    title("Third order derivative with scale: " + num2str(scale(i)),'FontSize', 20);
end


%% Q7 %%%% EXTRACTION OF EDGE SEGMENTS

%Images, thresholds for gradient magnitude and scaling values are defined
house = godthem256;
tools = few256;
threshold = [2 4 6 8 10 12];
scale = [0.0001 1 4 16 64];


%Extraction of edges from house image with different thresholds for the
%most useful scale value = 4
figure(1);
t3 = sgtitle("house edge extraction");
t3.FontSize = 25;
for i = 1:length(threshold)
    subplot(2,3,i);
    curves = extractedge(house,scale(3),threshold(i),"same");
    overlaycurves(house, curves);
    title("threshold: " + threshold(i) + " scale: " + scale(3),'FontSize', 20);
end

%Extraction of edges from tools image with different thresholds for the
%most useful scale value = 4
figure(2);
t3 = sgtitle("tools edge extraction");
t3.FontSize = 25;
for i = 1:length(threshold)
    subplot(2,3,i);
    curves = extractedge(tools,scale(3),threshold(i),"same");
    overlaycurves(tools, curves);
    title("threshold: " + threshold(i) + " scale: " + scale(3),'FontSize', 20);
end
    

%% Q8 %%%% HOUGH TRANSFORM

%Definition of test images
testimage1 = triangle128;
smalltest1 = binsubsample(testimage1);

testimage2 = houghtest256;
smalltest2 = binsubsample(binsubsample(testimage2));

%Definition of parameters for houghedgeline function
img = few256;
img2 = phonecalc256;
img3 = godthem256;
threshold = 10;
scale = 4;

nrho = 512;
ntheta = 512;
nlines = 10;
verbose = 0;

%Houghedgeline applications on different images
[linepar, acc] = houghedgeline(testimage1, scale, threshold, nrho, ntheta, nlines, verbose);
[linepar, acc] = houghedgeline(testimage2, scale, threshold, nrho, ntheta, nlines, verbose);
[linepar, acc] = houghedgeline(img, scale, threshold, nrho, ntheta, nlines, verbose);
[linepar, acc] = houghedgeline(img2, scale, threshold, nrho, ntheta, nlines, verbose);
[linepar, acc] = houghedgeline(img3, scale, threshold, nrho, ntheta, nlines, verbose);
%% Q9
%Image and houghedgeline parameter definitions
img = godthem256;

threshold = 10;
scale = 4;
nlines = 10;
verbose = 0;

%We have four cases here which are as:
%Case 1)small nrho - small ntheta
%Case 2)large nrho - small ntheta
%Case 3)small nrho - large ntheta
%Case 4)large nrho - large ntheta

%In those cases, we used tic-toc combination to observe how much time each
%process takes to be finished and displayed them along with their
%corresponding hough transform and hough lined versions

%Case 1)small nrho - small ntheta
disp("Duration for small nrho and small ntheta");
%Case with small nrho and small ntheta
tic
srho = 100;
stheta = 100;
[linepar, acc] = houghedgeline(img, scale, threshold, srho, stheta, nlines, verbose);
toc

%Case 2)large nrho - small ntheta
disp("Duration for large nrho and small ntheta");
%Case with large nrho and small ntheta
tic
lrho = 1000;
stheta = 100;

[linepar, acc] = houghedgeline(img, scale, threshold, lrho, stheta, nlines, verbose);
toc

%Case 3)small nrho - large ntheta
disp("Duration for small nrho and large ntheta");
%Case with small nrho and large ntheta
tic
srho = 100;
ltheta = 1000;

[linepar, acc] = houghedgeline(img, scale, threshold, srho, ltheta, nlines, verbose);
toc

%Case 4)large nrho - large ntheta
disp("Duration for large nrho and large ntheta");
%Case with large nrho and large ntheta
tic
lrho = 1000;
ltheta = 1000;

[linepar, acc] = houghedgeline(img, scale, threshold, lrho, ltheta, nlines, verbose);
toc
%% Q10 Different incrementations based on gradient magnitude
%Image and houghedgeline parameter definitions
img = few256;
threshold = 10;
scale = 4;

nrho = 512;
ntheta = 512;
nlines = 15;
verbose = 0;
%Attempting different incrementations. To change it please check Q10
%related field in houghline file starting from line 58
[linepar, acc] = houghedgeline(img, scale, threshold, nrho, ntheta, nlines, verbose);