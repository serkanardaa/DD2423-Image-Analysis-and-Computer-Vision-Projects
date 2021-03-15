function pixels = Lvvvtilde(inpic, shape)
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
      
%Third order derivatives by convolving the masks

dxxxmask = conv2(dxmask, dxxmask, shape);
dyyymask = conv2(dymask, dyymask, shape);
dxyymask = conv2(dxmask, dyymask, shape);
dxxymask = conv2(dxxmask, dymask, shape);
      
     
%Calculation of partial derivatives with required orders for our input image      
Lx = filter2(dxmask, inpic, shape);
Ly = filter2(dymask, inpic, shape);
Lxxx = filter2(dxxxmask, inpic, shape); 
Lyyy = filter2(dyyymask, inpic, shape);
Lxyy = filter2(dxyymask, inpic, shape);
Lxxy = filter2(dxxymask, inpic, shape);


%Now we can calculate Lvvv from given expression in the lab manual. We do
%not consider denominator since we will only check its sign
pixels = Lx.^3.*Lxxx + 3.*Lx.^2.*Ly.*Lxxy + 3.*Lx.*Ly.^2.*Lxyy + Ly.^3.*Lyyy;
end




