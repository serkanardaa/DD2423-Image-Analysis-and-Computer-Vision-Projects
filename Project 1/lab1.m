% IMAGE ANALYSIS AND COMPUTER VISION: LAB1 CODE BY SERKAN ARDA YILAL
%% Q1

%Different points and size definition
inputs = [5 9; 9 5; 17 9; 17 121; 5 1; 125 1];
sz = 128;

%Step by step, points are visualized according to the visualizations in
%fftwave
for k = 1:length(inputs)
    u = inputs(k,1);
    v = inputs(k,2);
    fftwave(u,v,sz);
    pause
end
%% Q2
sz = 128;
% Three points are defined
u1 = 15;
v1 = 15;

u2 = 30;
v2 = 1;

u3 = 105;
v3 = 112;
%Created Fourier image and inverse transformed it for first point
Fhat1 = zeros(sz);
Fhat1(u1,v1) = 1;
F1 = ifft2(Fhat1);
Fabsmax1 = max(abs(F1(:)));
%Created Fourier image and inverse transformed it for second point
Fhat2 = zeros(sz);
Fhat2(u2,v2) = 1;
F2 = ifft2(Fhat2);
Fabsmax2 = max(abs(F2(:)));
%Created Fourier image and inverse transformed it for third point
Fhat3 = zeros(sz);
Fhat3(u3,v3) = 1;
F3 = ifft2(Fhat3);
Fabsmax3 = max(abs(F3(:)));
%Centralized point calculations for first point
  if (u1 <= sz/2)
    uc1 = u1 - 1;
  else
    uc1 = u1 - 1 - sz;
  end
  if (v1 <= sz/2)
    vc1 = v1 - 1;
  else
    vc1 = v1 - 1 - sz;
  end
%Centralized point calculations for second point
  if (u2 <= sz/2)
    uc2 = u2 - 1;
  else
    uc2 = u2 - 1 - sz;
  end
  if (v2 <= sz/2)
    vc2 = v2 - 1;
  else
    vc2 = v2 - 1 - sz;
  end
%Centralized point calculations for third point
  if (u3 <= sz/2)
    uc3 = u3 - 1;
  else
    uc3 = u3 - 1 - sz;
  end
  if (v1 <= sz/2)
    vc3 = v3 - 1;
  else
    vc3 = v3 - 1 - sz;
  end
  %Visualization of centered points and imaginary part of their inverse
  %fourier transform in order to define point position and sine wave
  %relationship
  
  %First point
  subplot(3, 2, 1);
  showgrey(fftshift(Fhat1));
  title(sprintf('centered Fhat1: (uc1, vc1) = (%d, %d)', uc1, vc1))
  subplot(3, 2, 2);
  showgrey(imag(F1), 64, -Fabsmax1, Fabsmax1);
  title('imag(F1)')
  %Second Point
  subplot(3, 2, 3);
  showgrey(fftshift(Fhat2));
  title(sprintf('centered Fhat2: (uc2, vc2) = (%d, %d)', uc2, vc2))
  subplot(3, 2, 4);
  showgrey(imag(F2), 64, -Fabsmax2, Fabsmax2);
  title('imag(F2)')
  %Third Point
  subplot(3, 2, 5);
  showgrey(fftshift(Fhat3));
  title(sprintf('centered Fhat3: (uc3, vc3) = (%d, %d)', uc3, vc3))
  subplot(3, 2, 6);
  showgrey(imag(F3), 64, -Fabsmax3, Fabsmax3);
  title('imag(F3)')
%% Q5 
% Two points are defined for positions lower than half size of the image
% and higher than half size of the image
inputs = [60 60 ; 70 70];
sz = 128;
%Change comparison for exceeding half size of the image
for k = 1:length(inputs)
    u = inputs(k,1);
    v = inputs(k,2);
    fftwave(u,v,sz);
    pause
end
%% Q 7 8 9
%Matrixes are defined
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;
%Fourier transforms of the matrixes are calculated
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);
%Visualization of  matrix F in spatial domain, fourier domain, and
%logartihmic calculated fourier domain for better visualization
figure(1);
subplot(1,3,1);
showgrey(F);
title("F")
subplot(1,3,2);
showgrey(abs(Fhat));
title("Fhat")
subplot(1,3,3);
showgrey(log(1 + abs(Fhat)));
title("Fourier Spectra of Fhat")
%Visualization of  matrix G in spatial domain, fourier domain, and
%logartihmic calculated fourier domain for better visualization
figure(2);
subplot(1,3,1);
showgrey(G);
title("G")
subplot(1,3,2);
showgrey(abs(Ghat));
title("Ghat")
subplot(1,3,3);
showgrey(log(1 + abs(Ghat)));
title("Fourier Spectra of Ghat")
%Visualization of  matrix H in spatial domain, fourier domain, and
%logartihmic calculated fourier domain for better visualization
figure(3);
subplot(1,3,1);
showgrey(H);
title("H")
subplot(1,3,2);
showgrey(abs(Hhat));
title("Hhat")
subplot(1,3,3);
showgrey(log(1 + abs(Hhat)));
title("Fourier Spectra of Hhat")
%Visualization of  matrix H in spatial domain, shifted fourier domain and
%logarithmic calculated shifted fourier domain in order to show the result
%better at the center
figure(4);
subplot(1,3,1);
showgrey(H);
title("H")
subplot(1,3,2);
showgrey(abs(fftshift(Hhat)));
title("fftshift(Hhat)")
subplot(1,3,3);
showgrey(log(1 + abs(fftshift(Hhat))));
title("Fourier Spectra of Shifted Hhat")
%% Q 10
%Matrix F and G calculated along with their fourier transforms
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
Fhat = fft2(F);
Ghat = fft2(G);
size = 128;
% MULTIPLICATION IN SPATIAL DOMAIN > CONVOLUTION IN FOURIER DOMAIN

%Multiplication in spatial domain is calculated then its fourier transform
%is calculated
SpatMul = F .* G;
SpatMulhat = fft2(SpatMul);

%Convolution of individual fourier transforms of matrix F and G.
%Normalization is applied in order to achieve the same result. Also size is
%reduced to the original image size since convolution results with
%extension of the image components of convolution.
convhat = conv2(Fhat,Ghat)/(size^2);
convhat = convhat(1:size,1:size);
%Inverse fourier transform and shift is applied in order to achieve the
%same original image
conv = fftshift(ifft2(convhat));

%Visualizations of image and its fourier transform calculated by spatial
%multiplication
 figure(1);
 subplot(2,2,1);
 showgrey(SpatMul);
 title("Multiplication in Spatial Domain");
 subplot(2,2,2);
 showfs(SpatMulhat);
 title("FFT of Multiplication in Spatial Domain");
%Visualizations of image and its fourier transform calculated by Fourier
%Convolution
 subplot(2,2,3);
 showfs(conv);
 title("IFFT of Convolution in Frequency Domain");
 subplot(2,2,4);
 showfs(convhat);
 title("Normalized Convolution in Frequency Domain");
 
%% Q 11
%Images from previous question are defined with their fourier transform
Fprev = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
Gprev = Fprev';
SpatMul = Fprev .* Gprev;
SpatMulhat = fft2(SpatMul);

%New Scaled version of the image which has white are of twice the
%horizontal
%length and half the vertical length of the previous image
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];
figure(1);

%Spatial and Fourier representation of previous image
subplot(2,2,1);
showgrey(SpatMul);
title("Previous Image in Spatial Domain");
subplot(2,2,2);
showfs(SpatMulhat);
title("Previous Image in Fourier Domain");

%Spatial and Fourier representation of new scaled image
subplot(2,2,3);
showgrey(F);
title("New Image in Spatial Domain");
subplot(2,2,4);
showfs(fft2(F));
title("New Image in Fourier Domain");

%% Q 12
%Original Image is defined and fourier transform of it is calculated
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];

Fhat = fft2(F);


figure(1);
%Visualization of Original image in spatial and fourier domain in first
%figure
subplot(1,2,1);
showgrey(F);
title("Original Image in Spatial Domain");
subplot(1,2,2);
showfs(fft2(F));
title("Original Image in Fourier Domain");

figure(2);
%Rotation Degrees are defined
alpha = [30,45,60,90];
%Rotation operations are applied in spatial domain
G30 = rot(F, alpha(1) );
G45 = rot(F, alpha(2) );
G60 = rot(F, alpha(3) );
G90 = rot(F, alpha(4) );
%Fourier transforms of rotated images are calculated
Ghat30 = fft2(G30);
Ghat45 = fft2(G45);
Ghat60 = fft2(G60);
Ghat90 = fft2(G90);
%Inverse rotation is applied in fourier domain to the shifted version of
%rotated fouriers
Hhat30 = rot(fftshift(Ghat30), -alpha(1) );
Hhat45 = rot(fftshift(Ghat45), -alpha(2) );
Hhat60 = rot(fftshift(Ghat60), -alpha(3) );
Hhat90 = rot(fftshift(Ghat90), -alpha(4) );

%Representation of rotated image in spatial domain, fourier domain, and
%Inverse rotated in fourier domain for rotation angle 30
subplot(4,3,1);
showgrey(G30);
title("30 Deg. Rot. in Spatial Dom.");
axis on
subplot(4,3,2);
showfs(Ghat30);
title("30 Deg. Rot. in Fourier Dom.");
subplot(4,3,3);
showgrey(log(1 + abs(Hhat30)));
title("30 Deg. Inv. Rot. in Fourier Dom.");

%Representation of rotated image in spatial domain, fourier domain, and
%Inverse rotated in fourier domain for rotation angle 45
subplot(4,3,4);
showgrey(G45);
title("45 Deg. Rot. in Spatial Dom.");
axis on
subplot(4,3,5);
showfs(Ghat45);
title("45 Deg. Rot. in Fourier Dom.");
subplot(4,3,6);
showgrey(log(1 + abs(Hhat45)));
title("45 Deg. Inv. Rot. in Fourier Dom.");

%Representation of rotated image in spatial domain, fourier domain, and
%Inverse rotated in fourier domain for rotation angle 60
subplot(4,3,7);
showgrey(G60);
title("60 Deg. Rot. in Spatial Dom.");
axis on
subplot(4,3,8);
showfs(Ghat60);
title("60 Deg. Rot. in Fourier Dom.");
subplot(4,3,9);
showgrey(log(1 + abs(Hhat60)));
title("60 Deg. Inv. Rot. in Fourier Dom.");

%Representation of rotated image in spatial domain, fourier domain, and
%Inverse rotated in fourier domain for rotation angle 90
subplot(4,3,10);
showgrey(G90);
title("90 Deg. Rot. in Spatial Dom.");
axis on
subplot(4,3,11);
showfs(Ghat90);
title("90 Deg. Rot. in Fourier Dom.");
subplot(4,3,12);
showgrey(log(1 + abs(Hhat90)));
title("90 Deg. Inv. Rot. in Fourier Dom.");
%% Q13
%Images are defined
img1= phonecalc128;
img2 = few128;
img3 = nallo128;
%Magnitudes of the images are changed with pow2image() function
powimg1 = pow2image(img1,10^-10);
powimg2 = pow2image(img2,10^-10);
powimg3 = pow2image(img3,10^-10);
%Phases of the images are changed with randphaseimage() function
rphaseimg1 = randphaseimage(img1);
rphaseimg2 = randphaseimage(img2);
rphaseimg3 = randphaseimage(img3);

%Represantation of phonecalc128 in original, magnitude changed, and phase
%changed form
figure(1);
subplot(3,3,1);
showgrey(img1);
title("Image phonecalc128");
subplot(3,3,2);
showgrey(powimg1);
title("Magnitude changed phonecalc128");
subplot(3,3,3);
showgrey(rphaseimg1);
title("Phase changed phonecalc128");

%Represantation of few128 in original, magnitude changed, and phase
%changed form
subplot(3,3,4);
showgrey(img2);
title("Image few128");
subplot(3,3,5);
showgrey(powimg2);
title("Magnitude changed few128");
subplot(3,3,6);
showgrey(rphaseimg2);
title("Phase changed few128");

%Represantation of nallo128 in original, magnitude changed, and phase
%changed form
subplot(3,3,7);
showgrey(img3);
title("Image nallo128");
subplot(3,3,8);
showgrey(powimg3);
title("Magnitude changed nallo128");
subplot(3,3,9);
showgrey(rphaseimg3);
title("Phase changed nallo128");

%% Q 14
%Variance parameters for gaussian filter are defined
t = [0.1 0.3 1 10 100];

%delta function is filtered with new defined gaussian filter and its
%spatial convariance matrixes are printed as well as its impulse responses
%are displayed for different t values
figure(1);
for i = 1:length(t)
    subplot(3,2,i);
    psf = gaussfft(deltafcn(128, 128), t(i));
    showgrey(psf);
    disp("The spatial covariance matrix computed with gaussfft for t = " + num2str(t(i)) + " is:");
    disp(variance(psf));
    title("Impulse Response with gaussfft for t = " + num2str(t(i)));
end

%delta function is filtered with provided predefined gaussian filter and its
%spatial convariance matrixes are printed as well as its impulse responses
%are displayed for different t values
figure(2);
for i = 1:length(t)
    subplot(3,2,i);
    psf = discgaussfft(deltafcn(128, 128), t(i));
    showgrey(psf);
    disp("The spatial covariance matrix computed with discgaussfft for t = " + num2str(t(i)) + " is:");
    disp(variance(psf));
    title("Impulse Response with discgaussfft for t = " + num2str(t(i)));
end


%% Q 15
%t values are defined for gaussian covariance calculations
t = [0.1 0.3 1 10 100];

%Impulse response of new defined gaussian and provided predefined gaussian
%are calculated and the absolute difference of their variances are
%calculated and printed
for i = 1:length(t)
    psf = gaussfft(deltafcn(128, 128), t(i));
    psfdisc = discgaussfft(deltafcn(128, 128), t(i));
    disp("The spatial covariance matrix difference between computed and estimated variance for t = " + num2str(t(i)) + " is:");
    disp(abs(variance(psf)-variance(psfdisc)));
end
%Impulse response of new defined gaussian is
%calculated and the absolute difference of variance of new defined gaussian and
%continous case variance are calculated and printed
for i = 1:length(t)
    psf = gaussfft(deltafcn(128, 128), t(i));
    cont_variance = t(i)*eye(2);
    disp("The spatial covariance matrix difference between computed variance and continuous case for t = " + num2str(t(i)) + " is:");
    disp(abs(variance(psf)-cont_variance));
end
%% Q 16
%Images are defined along with variance variables t
img1= phonecalc128;
img2 = few128;
img3 = nallo128;
t = [1 4 16 64 256];

%phonecalc128 is gaussian filtered with different t values
figure(1);
for i = 1:length(t)
    subplot(3,2,i);
    psf1 = gaussfft(img1, t(i));
    showgrey(psf1);
    title("Impulse Response of phonecalc128 with gaussfft for t = " + num2str(t(i)));
end
%few128 is gaussian filtered with different t values
figure(2);
for i = 1:length(t)
    subplot(3,2,i);
    psf2 = gaussfft(img2, t(i));
    showgrey(psf2);
    title("Impulse Response of few128 with gaussfft for t = " + num2str(t(i)));
end
%nallo128 is gaussian filtered with different t values
figure(3);
for i = 1:length(t)
    subplot(3,2,i);
    psf3 = gaussfft(img3, t(i));
    showgrey(psf3);
    title("Impulse Response of nallo128 with gaussfft for t = " + num2str(t(i)));
end
%% Q 17 18
%Image is defined
office = office256;
%Gaussian noise and SAP noise are added to the defined image
add = gaussnoise(office, 16);
sap = sapnoise(office, 0.1, 255);

%Parameteres of different filters are defined
t = [0.1 1 10]; %Variance parameter for Gaussian Filter
wsize = [3 8 12]; % Window size for Median Filter
cfreq = [0.3 0.2 0.1]; %Cut-off Frequency for Ideal LP Filter

%Images with Gaussian and SAP noise are displayed
figure(1);
subplot(1,2,1);
showgrey(add);
title("Image with Gaussian Noise");
subplot(1,2,2);
showgrey(sap);
title("Image with Salt and Pepper Noise");
figure(2);

%Effects of Gaussian Filter on Gaussian and SAP noise are calculated and
%displayed for different variance values
for i = 1:length(t)
    subplot(2,3,i);
    filtered_add = gaussfft(add, t(i));
    showgrey(filtered_add);
    title("Gaussian Filtered Gaussian Noised Image for t = " + num2str(t(i)));
    subplot(2,3,3+i);
    filtered_sap = gaussfft(sap, t(i));
    showgrey(filtered_sap);
    title("Gaussian Filtered Salt and Pepper Noised Image for t = " + num2str(t(i)));
end

%Effects of Median Filter on Gaussian and SAP noise are calculated and
%displayed for different window sizes
figure(3);
for i = 1:length(wsize)
    subplot(2,3,i);
    filtered_add = medfilt(add, wsize(i));
    showgrey(filtered_add);
    title("Median Filtered Gaussian Noised Image for wsize = " + num2str(wsize(i)));
    subplot(2,3,3+i);
    filtered_sap = medfilt(sap, wsize(i));
    showgrey(filtered_sap);
    title("Median Filtered Salt and Pepper Noised Image for wsize = " + num2str(wsize(i)));
end

%Effects of Ideal LP Filter on Gaussian and SAP noise are calculated and
%displayed for different cut-off frequencies
figure(4);
for i = 1:length(cfreq)
    subplot(2,3,i);
    filtered_add = ideal(add, cfreq(i));
    showgrey(filtered_add);
    title("Ideal LP Filtered Gaussian Noised Image for cfreq = " + num2str(cfreq(i)));
    subplot(2,3,3+i);
    filtered_sap = ideal(sap, cfreq(i));
    showgrey(filtered_sap);
    title("Ideal LP Filtered Salt and Pepper Noised Image for cfreq = " + num2str(cfreq(i)));
end
%% Q 19 20
%Images are prepared for non-smoothed and smoothed applications for
%gaussian and ideal LP filter
img_gauss = phonecalc256;
img_ideal = phonecalc256;
smoothimg_gauss = img_gauss;
smoothing_ideal = img_ideal;
N=5;
figure(1);

for i=1:N
    if i>1 % generate subsampled versions
        img_gauss = rawsubsample(img_gauss);
        smoothimg_gauss = gaussfft(smoothimg_gauss, 1);%Best variance variable is found to be 1
        smoothimg_gauss = rawsubsample(smoothimg_gauss);
    end
    %One by one, images for subsampling and their smoothed sampling are
    %compared for Gaussian Filter with variance t=1
    subplot(2, N, i);
    showgrey(img_gauss);
    title("i = " + (i-1) + " No smoothing");
    subplot(2, N, i+N);
    showgrey(smoothimg_gauss);
    title("i = " + (i-1) + " Gaussian t = 1");
end
figure(2);

for i=1:N
    if i>1 % generate subsampled versions
        img_ideal = rawsubsample(img_ideal);
        smoothing_ideal = ideal(smoothing_ideal, 0.2);%Best cut-off frequency is found to be 0.2
        smoothing_ideal = rawsubsample(smoothing_ideal);
    end
    %One by one, images for subsampling and their smoothed sampling are
    %compared for Ideal LP Filter with cut-off frequency cfreq=0.2
    subplot(2, N, i);
    showgrey(img_ideal);
    title("i = " + (i-1) + " No smoothing");
    subplot(2, N, i+N);
    showgrey(smoothing_ideal);
    title("i = " + (i-1) + " Ideal LP cfreq = 0.2");
end
