function [linepar acc] = ...
houghline(curves, magnitude, ...
nrho, ntheta, threshold, nlines, verbose)


%Initizalization of acc with given nrho and ntheta
acc = zeros(nrho, ntheta);

%Creating the accumulator coordinate system by defining theta and r
%intervals
% theta axis is defined considering limits are 90 and -90 degrees
theta_axis = linspace(-pi/2, pi/2, ntheta);

%Calculating the rho limit by checking the diagonal length of the input
%gradient magnitude
rho_limit = sqrt(size(magnitude,1).^2 + size(magnitude,2).^2);

%r axis is defined considering limits as rho_limit and -rho_limit

rho_axis = linspace(-rho_limit, rho_limit, nrho);

%Preparing required parameters to loop over the pixels over the edge curves
insize = size(curves, 2);
try_pointer = 1; 

%starting the loop over the pixels located on the curve

while try_pointer < insize
    poly_length = curves(2, try_pointer); %first row = y, second row = x so we check x value of the curve
    try_pointer = try_pointer + 1;
    
    %looping over the points of the current edge
    for curve = 1:poly_length
        x_coordinate = curves(2, try_pointer);
        y_coordinate = curves(1, try_pointer);
        try_pointer = try_pointer + 1;
        
        %Checking if the corresponding coordinate in gradient magnitude is above
        %the threshold
        magn_coordinate = abs(magnitude(round(x_coordinate), round(y_coordinate)));
        if magn_coordinate > threshold
            
            % on that point, for each theta value that we can have, we will
            % calculate rho value and increase the vote for corresponding
            % accumulator point that has these values
            for theta_index = 1:ntheta
                %calculating value of rho for each theta value at that
                %coordinate
                rho_value = x_coordinate*cos(theta_axis(theta_index)) + y_coordinate*sin(theta_axis(theta_index));
                
                %finding the index in rho_axis that has a value closest to
                %rho_value
                rho_index = find(rho_axis < rho_value, 1, 'last');
                
                %increment the vote value of corresponding index in the
                %accumulator
                
                %*********** Different incrementations for Q10********
                %Incrementing by 1
                acc(rho_index, theta_index) = acc(rho_index, theta_index) + 1;

%                 %Incrementing propotional to logarithm of gradient
%                 %magnitude of the point
%                 acc(rho_index, theta_index) = acc(rho_index, theta_index) + log(magn_coordinate);

%                 %Incrementing propotional to gradient magnitude of the
%                 %point
%                 acc(rho_index, theta_index) = acc(rho_index, theta_index) + magn_coordinate;

%                 %Incrementing propotional to cube of gradient magnitude of the
%                 %point
%                 acc(rho_index, theta_index) = acc(rho_index, theta_index) + magn_coordinate.^3;
            end
        end
    end
end


%Detection of Local Maxima from accumulator
[pos value] = locmax8(acc);
[dummy indexvector] = sort(value);
nmaxima = size(value, 1);

%Calculation of indexes of local maximas in accumulator and addin n
%top lines according to input nlines

for index = 1:nlines
    %starting from the stronges local maxima and checking from the end since
    %sort function gave indexvector in ascending order
    
    %Getting rho index for local maxima
    rho_index_accumulator = pos(indexvector(nmaxima - index + 1), 1);
    %Getting theta index for local maxima
    theta_index_accumulator = pos(indexvector(nmaxima - index + 1), 2);
    %Getting corresponding value in rho_axis
    line_rho = rho_axis(rho_index_accumulator);
    %Getting corresponding value in theta_axis
    line_theta = theta_axis(theta_index_accumulator);
    %adding the position of line
    linepar(:,index) = [line_rho; line_theta];
    
    
    %Lines that illustrate the results. Transforming them into image
    %coordinate system
    x0 = 0;
    y0 = (line_rho - x0 * cos(line_theta))./sin(line_theta);
    dx = rho_limit.^2;
    dy = (line_rho - dx * cos(line_theta))./sin(line_theta);
    
    
    outcurves(1, 4*(index-1) + 1) = 0;          
    outcurves(2, 4*(index-1) + 1) = 3;
    outcurves(2, 4*(index-1) + 2) = x0 - dx;
    outcurves(1, 4*(index-1) + 2) = y0 - dy;
    outcurves(2, 4*(index-1) + 3) = x0;
    outcurves(1, 4*(index-1) + 3) = y0;
    outcurves(2, 4*(index-1) + 4) = x0+dx;
    outcurves(1, 4*(index-1) + 4) = y0+dy;
end

%Return the outcurves as output
linepar = outcurves;
end




