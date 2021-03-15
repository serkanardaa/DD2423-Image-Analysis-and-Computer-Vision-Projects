function [segmentation, centers] = kmeans_segm(image, K, L, seed)

%Converting image to double to keep precisions
img = double(image);


%Reshaping the 3D image format to 2D image format for better performance by combining heigth and
%width and keeping RGB as the second dimension 

[height, width, RGB] = size(img);
%Pixels are defined
X = reshape(img, height*width, 3);




%1-Randomly initialize the K cluster centers

%Defining min and max RGB values before randomization
RGB_min = int16(min(X));
RGB_max = int16(max(X));

%Randomization with min and max values for each color component in size K x 1

R = randi([RGB_min(1), RGB_max(1)], K, 1); 
G = randi([RGB_min(2), RGB_max(2)], K, 1);
B = randi([RGB_min(3), RGB_max(3)], K, 1);

%Then we combine those components to keep RGB values of each cluster center
K_centers = [R, G, B];

%2-Compute all distances between pixels and cluster centers
distance = pdist2(X, K_centers);

%3-Iterate L times

for i = 1:L 
    %4-Assign each pixel to the cluster center for which the distance is minimum
    %Creating a matrix for keeping assigned pixels(with their RGB) for each clusters
    K_assigned_pix = double(zeros(K,3));
    %Counting number of pixels assigned for each cluster
    K_count_pix = double(zeros(K,1));
    for pix = 1:length(X(:,1))
        %For each pixel, initializing assignment as if all are assigned to cluster 1
        assigned_K(pix) = 1;
        min_distance = distance(pix,assigned_K(pix));
        %Comparing the distance of initialization with other clusters and
        %find the minimum distance if there is a closer cluster to that
        %pixel
        for k = 2:K
            if (distance(pix,k) < min_distance)
                assigned_K(pix) = k;
                min_distance = distance(pix,k);
            end
        end
        %Filling the cluster with assigned pixels` RGB values and counting
        %the added pixel
        K_assigned_pix(assigned_K(pix), 1) = K_assigned_pix(assigned_K(pix), 1) + X(pix, 1);
        K_assigned_pix(assigned_K(pix), 2) = K_assigned_pix(assigned_K(pix), 2) + X(pix, 2);
        K_assigned_pix(assigned_K(pix), 3) = K_assigned_pix(assigned_K(pix), 3) + X(pix, 3);
        K_count_pix(assigned_K(pix)) = K_count_pix(assigned_K(pix)) + 1;
    end
    %5-Recompute each cluster center by taking the mean of all pixels assigned to it
    for k = 1:K
        if(K_count_pix(k) > 0)
            K_centers(k,1) = K_assigned_pix(k, 1) ./ K_count_pix(k);
            K_centers(k,2) = K_assigned_pix(k, 2) ./ K_count_pix(k);
            K_centers(k,3) = K_assigned_pix(k, 3) ./ K_count_pix(k);
        end
    end
    %6-Recompute all distances between pixels and cluster centers
    distance = pdist2(X, K_centers);
end

%Preparing segmentation and centers for clusters

X_new = zeros(height*width, 1);
for pix=1:height*width
    X_new(pix) = assigned_K(pix);
end
segmentation = uint8(reshape(X_new, height, width, 1));
centers = K_centers;
end

        

