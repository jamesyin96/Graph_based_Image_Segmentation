% this function calculates the results of segment input image into two
% components and display the resulting segmentation

function Threshold = cal2Cuts(image, mask, sigma1, sigmax)

trackMask = length(find(mask == 1));

[height, width] = size(image); 
% get the w matrix
W = getW(image,mask,sigma1,sigmax);
d = sum(W,2);

% generate the diagonal matrix
D = spdiags(d,0,trackMask,trackMask);

% compute eigenvalues and vectors
d1 = d.^(-1/2);
D1 = spdiags(d1,0,height*width,height*width);
A = D1*(D-W)*D1;
k = 9;
[V,D_value] = eigs(A,k,'SM');
eigenValues = diag(D_value);


%get the vector corresponding to the second smallest eigenvalue
SMVector = V(:,2); 
Max_SMV = max(SMVector);
Min_SMV = min(SMVector);

SplitNum = 30;
SplitP = Min_SMV:(Max_SMV-Min_SMV)/(SplitNum-1):Max_SMV;
NCut = zeros(SplitNum,1);

for i = 1:SplitNum
    Threshold = SplitP(i);
    PartOne = SMVector;

    PartOne(PartOne>=Threshold) = 1;
    PartOne(PartOne<Threshold) = 0;

    [x_NZ,y_NZ,s_NZ] = find(W);
    TheOnes = xor(PartOne(uint16(x_NZ)),PartOne(uint16(y_NZ)));
    CutAB = sum(s_NZ(TheOnes));

    assocAV = sum(PartOne.*d);
    assocBV = sum(~PartOne.*d);
    NCut(i) = CutAB/assocAV + CutAB/assocBV;
end

% now we need to find out the part with best NCut
index = find(NCut == min(NCut));
Threshold = SplitP(index(1));

PartOne = SMVector;
ImageVector = reshape(image,[],1);

PartOne(PartOne>=Threshold) = 1;
PartOne(PartOne<Threshold) = 0;
ImageOneVector = ImageVector.*PartOne;
ImageOne = reshape(ImageOneVector,height,width);
figure; imshow(ImageOne);

PartTwo = ~PartOne;
ImageTwoVector = ImageVector.*PartTwo;
ImageTwo = reshape(ImageTwoVector,height,width);
figure(); 
imshow(ImageTwo);

end