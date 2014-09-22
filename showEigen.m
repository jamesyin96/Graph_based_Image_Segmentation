% this function takes the grey-scale input image and display its eigenvalue
% and eigenvectors as described in step 5
function showEigen(image,mask,sigma1,sigmax)

trackMask = length(find(mask == 1));

[height, width] = size(image); 
% get the w matrix
W = getW(image,mask,sigma1,sigmax);
d = sum(W,2);

% generate the diagonal matrix
D = spdiags(d,0,trackMask,trackMask);

% compute eigenvalues and vectors
d1 = d.^(-1/2);
D1 = spdiags(d1,0,trackMask,trackMask);
A = D1*(D-W)*D1;
k = 9;
[V,D_value] = eigs(A,k,'SM');
eigenValues = diag(D_value);

% plot the figures
figure;plot(abs(eigenValues),'+-');
xlabel('EigenVectors');
ylabel('EigenValues');

ImageEigenVector2 = reshape(V(:,2),height,width);
figure;imagesc(ImageEigenVector2);

ImageEigenVector3 = reshape(V(:,3),height,width);
figure;imagesc(ImageEigenVector3);

ImageEigenVector4 = reshape(V(:,4),height,width);
figure;imagesc(ImageEigenVector4);

ImageEigenVector5 = reshape(V(:,5),height,width);
figure;imagesc(ImageEigenVector5);

ImageEigenVector6 = reshape(V(:,6),height,width);
figure;imagesc(ImageEigenVector6);

ImageEigenVector7 = reshape(V(:,7),height,width);
figure;imagesc(ImageEigenVector7);

ImageEigenVector8 = reshape(V(:,8),height,width);
figure;imagesc(ImageEigenVector8);

ImageEigenVector9 = reshape(V(:,9),height,width);
figure;imagesc(ImageEigenVector9);