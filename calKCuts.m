% this functions calculates the result of image segmentation using
% k-way cuts based on k-means
% the inputs are: image, mask, criteria, sigma1, sigmax
% the ourputs are: the result of segmentation
function calKCuts(image,mask,K,sigma1,sigmax)

OnesinMask = length(find(mask == 1));

[height, width] = size(image); 

% W = sparse(height*width,height*width);
W = getW(image,mask,sigma1,sigmax);
d = sum(W,2);

% computer diagonal matrix
D = spdiags(d,0,OnesinMask,OnesinMask);
d1 = d.^(-1/2);
D1 = spdiags(d1,0,OnesinMask,OnesinMask);

% computer eigenvalues and vectors
A = D1*(D-W)*D1;
[V,D_value] = eigs(A,9,'SM');

%get the vector corresponding to the second smallest eigenvalue
N = 8;
newspace = V(:,2:N+1);
IDX = kmeans(newspace,K);
ImageVector = reshape(image,[],1);
for i = 1:K
    group = IDX;
    group(group ~= i) = 0;
    group(group == i) = 1;    
    groupImageArray = ImageVector.*group;
    groupImage = reshape(groupImageArray,height,width);
    figure();
    imshow(groupImage);
end
