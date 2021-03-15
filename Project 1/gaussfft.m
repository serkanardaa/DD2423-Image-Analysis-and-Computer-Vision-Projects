function filtered = gaussfft(pic, t)

 %We extract xsize and ysize of the input image to use it in the design of
 %Guassian Filter
 [xsize, ysize] = size(pic);
 
 %We create a mashgrid for gaussian filter such that it will be
 %centralized.
 [x, y] = meshgrid(-xsize/2 : (xsize/2)-1, -ysize/2 : (ysize/2)-1);
 
 %Gaussian Filter is defined with its definition
 GaussKernel = 1/(2*pi*t)*exp(-(x.^2+y.^2)./(2*t));
 
 %Input image and Gaussian filter is transformed to Fourier Domain
 pichat = fft2(pic);
 Gausshat = fft2(GaussKernel);
 
 %Fourier transforms of input image and gaussian filter are multiplied.
 filteredhat = pichat.*Gausshat;
 %Inverse fourier transform of multiplication in frequency domain is
 %calculated and the result is shifted to the center.
 filtered = fftshift(ifft2(filteredhat));