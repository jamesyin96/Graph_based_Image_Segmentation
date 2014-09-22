% this function find the row and column according to the index number
function [row col] = findInMatrix(M,index)
% find the height and width of the input matrix M
[height width] = size(M);
col = ceil(index/height);
row = index - (col-1) * height;
end
