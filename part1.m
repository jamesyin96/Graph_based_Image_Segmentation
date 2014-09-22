% the part 1, normalized graph cuts
% the input images are not the same dimensions, image2,3,4,5 are all RGB
% images, so we need to make a distinction here whether to convert the
% image into standard grey image
original_image = imread('segment_image5.bmp');
% we should pre-define these two values for each image
criteria = 0.02;
K = 6;

T = length(size(original_image));
% if the input image is a RGB image, we convert the image into a grey image
if T == 3
    image = rgb2gray(original_image);
else
    image = original_image;
end

% normalize the image
image = double(image)/255;

% the preallocation of some arguments such as r, sigma1 and sigmax. These
% values are from the paper.
r=5;
sigma1 = 0.1;
sigmax = 4.0;

[height, width] = size(image); 
mask = ones(1,height*width);

% First, show the eigenvalues and eigenvectors
 showEigen(image,mask,sigma1,sigmax);
% Second, compute the two-components segmentation and return the threshold
 cal2Cuts(image, mask, sigma1, sigmax)
% Third, compute the segmentation using recursively two-way cut
 calCuts(image,mask,criteria,sigma1,sigmax);
% Fourth, compute k-way cut using 
 calKCuts(image,mask,K,sigma1,sigmax);