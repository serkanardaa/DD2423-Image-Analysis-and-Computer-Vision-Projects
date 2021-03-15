function edgecurves = extractedge(inpic, scale, threshold, shape)


if (nargin<2)
    shape = "same";
    threshold = 0;
end

%Gradient magnitude calculation of the image with smoothing
Lv_inpic = Lv(discgaussfft(inpic, scale), shape);

%Second order derivative of the image with smoothing
Lvv = Lvvtilde(discgaussfft(inpic, scale), shape);

%Third order derivative of the image with smoothing
Lvvv = Lvvvtilde(discgaussfft(inpic, scale), shape);

%Masks for functions

%We threshold and keep the points above the threshold positive while making
%the points below threshold negative
Lv_thresholded = (Lv_inpic > threshold) -0.1;

%We check which points are has negative value and then we transform it such
%that points corresponding to negative points will be represented positive
%and positive points will be represented negative in order to disregard
%positive points in zero-crossing check.
Lvvv_negative = (Lvvv < 0) - 0.1;

%Look at when crossing zero
%We consider the edges where we have zero-crossing and having third order
%derivative negative value as we defined in lab manual
edgecurves = zerocrosscurves(Lvv, Lvvv_negative);

%we use the previous result and thresholded gradients as input so that only
%the edges that satisfy thresholded gradient will be considered.
edgecurves = thresholdcurves(edgecurves, Lv_thresholded);

end
