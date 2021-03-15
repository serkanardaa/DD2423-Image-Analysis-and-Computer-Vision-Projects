function [segmentation, centers] = kmeans_prob(I, K, L, seed)
%Preparing cluster center matrix according to input K
K_centers = zeros(K, 3);
nthreshold = 2;

%Randomly selecting cluster centers from pixels of the input image
idx = randperm(size(I, 1), K);
for i = 1 : K
    K_centers(i, :) = I(idx(i), :);
end

%Calculationg euclidian distance between image pixels and cluster centers
Dist = pdist2(K_centers, I, 'euclidean');

for i = 1 : L
    [~, center_id] = min(Dist);
    
    %Recalculating according to nthreshold
    for j = 1 : K
        n_idx = find(center_id == j);
        if size(n_idx, 2) < nthreshold
            K_centers(j, :) = rand(1, 3);
        else
            K_centers(j, :) = double(mean(I(n_idx, :)));
        end
    end
    Dist = pdist2(K_centers, I, 'euclidean');
end

[~, center_id] = min(Dist);
segmentation = center_id;
centers = K_centers;