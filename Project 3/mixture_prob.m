function [prob] = mixture_prob (img, K, L, mask)


%Getting row and column information from the input image
img_rows = size(img, 1);
img_cols = size(img, 2);

%1- Let I be a set of pixels and V a set of K Guassian comp in 3D
%(R,G,B)---
I = im2double(reshape(img, img_rows * img_cols, 3));
M = reshape(mask, img_rows * img_cols, 1);

I_one = I(find(M == 1), :);
G = zeros(size(I_one, 1), K);

%2- Randomly initialize the K components using masked pixels---

[segmentation, centers] = kmeans_prob(I_one, K, L, 4321);
%Initializing Covariance Matrix
cov = cell(K, 1);
cov(:) = {rand * eye(3)};

%Initializing Weight vector
w = zeros(1, K);

for i = 1 : K
    w(i) = sum(segmentation == i) / size(segmentation, 1);
end


G1 = zeros(img_rows * img_cols, K);

%3- Iterate L times
for i = 1 : L
    
    %4- Expectation: Compute probabilities P_ik using masked pixels---
    
    for k = 1 : K
        mean_k = centers(k, :);
        cov_k = cov{k};
        diff = bsxfun(@minus, I_one, mean_k);
        %Gaussian Component Formulation
        G(:, k) = 1 / sqrt(det(cov_k) * (2 * pi) ^ 3) * exp(-0.5 * sum((diff * inv(cov_k) .* diff), 2));
    end
    
    p = bsxfun(@times, G, w);
    normed = sum(p, 2);
    p = bsxfun(@rdivide, p, normed);
    
    %5- Maximization: Update weights, means and covariances using masked
    %pixels---
    
    w = sum(p, 1) / size(p, 1);
    for k = 1 : K
        total = sum(p(:, k), 1);
        centers(k, :) = p(:, k)' * I_one / total;
        diff = bsxfun(@minus, I_one, centers(k, :));
        cov{k} = (diff' * bsxfun(@times, diff, p(:, k))) / total;
    end
end

%6- Compute probabilities p(c_i) in Eq.(3) for all pixels I---
for k = 1 : K
    mean_k = centers(k, :);
    cov_k = cov{k};
    diff = bsxfun(@minus, I, mean_k);
    G1(:, k) = 1 / sqrt(det(cov_k) * (2 * pi)^3) * exp(-1/2 * sum((diff * inv(cov_k) .* diff), 2));
end

%converting prob back to the input image format
prob_2D = sum(bsxfun(@times, G1, w), 2);
prob = reshape(prob_2D, img_rows, img_cols, 1);

end
