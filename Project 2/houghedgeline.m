function [linepar acc] = ...
houghedgeline(pic, scale, gradmagnthreshold, ...
nrho, ntheta, nlines, verbose)

%getting curves from extractedge function
curves = extractedge(pic, scale, gradmagnthreshold, 'same');
%Calculating gradient magnitude
magnitude = Lv(pic, 'same');

%calculating houghlines with given inputs
[linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);

             
%Verbose level 0: It will show the image with lines and hough transform of
%it

if verbose == 0
    figure;
    subplot(1,2,1);
    showgrey(binsepsmoothiter(acc, 0.5, 1));
    title('Hough transform with smoothing','FontSize', 20)
    subplot(1,2,2);
    overlaycurves(pic, linepar);
    axis([1 size(pic, 2) 1 size(pic, 1)]); 
    title("Image with nlines",'FontSize', 20);
end

%Verbose level 1: It will show the image with curves and the magnitude of
%the image
if verbose == 1
    figure;
    subplot(1,2,1);
    overlaycurves(pic, curves);
    title('Image with curves','FontSize', 20);
    subplot(1,2,2);
    showgrey(magnitude);
    title('Image magnitude','FontSize', 20);
end
%Verbose level 2:It will show hough transform and smoothed hough transform
if verbose == 2
    figure;
    subplot(1,2,1);
    showgrey(acc);
    title('Acc','FontSize', 20);
    subplot(1,2,2);
    showgrey(binsepsmoothiter(acc, 0.5, 1));
    title('Smoothed Acc','FontSize', 20);
end

end



