function pixels = Lvvtilde(inpic, shape)
if (nargin<2)
    shape = "same";
end

% In order for the image boundaries to be treated consistently for all
% derivative approximations, we set the sizes 5x5

%First order derivatives
dxmask = [0 0 0 0 0;
          0 0 0 0 0; 
          0 -1/2 0 1/2 0;
          0 0 0 0 0;
          0 0 0 0 0];
      
dymask = [0 0 0 0 0;
          0 0 -1/2 0 0;
          0 0 0 0 0;
          0 0 1/2 0 0;
          0 0 0 0 0];
      
%Second order derivatives

dxxmask = [0 0 0 0 0;
          0 0 0 0 0; 
          0 1 -2 1 0;
          0 0 0 0 0;
          0 0 0 0 0];
      
dyymask = [0 0 0 0 0;
          0 0 1 0 0;
          0 0 -2 0 0;
          0 0 1 0 0;
          0 0 0 0 0];
      
     
%Convolving 2 masks in order to calculate Lxy in next step
dxymask = conv2(dxmask, dymask, shape);


%Calculation of partial derivatives with required orders for our input image      
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
Lxx = filter2(dxxmask, inpic, shape);
Lyy = filter2(dyymask, inpic, shape);
Lxy = filter2(dxymask, inpic, shape);


%Now we can calculate Lvv from given expression in the lab manual. We do
%not consider denominator since we will only check its sign
pixels = Lx.^2.*Lxx + 2.*Lx.*Lxy.*Ly + Ly.^2.*Lyy;
end




