% this function joins two labeled areas, the large area that jioned toghter
% will be labeled with the smaller number between l1 and l2, also the
% threshold will be unified
function [newlabel newthreshold]=join(p1,p2,edge,imagelabel,threshold,k)
% first get the label of the two labeled area
l1 = imagelabel(p1);
l2 = imagelabel(p2);

% fill in the largly labeled area with smaller label number
l = min(l1,l2);
if l==l1
    imagelable(imagelabel == l2) = l;
else
    imagelabel(imagelabel == l1) = l;
end

% calculate the new threshold accordingly
new_label_size = length(find(imagelabel == l));
new_threshold = edge + k/new_label_size;

% unify the threshold to threshold arrry
threshold(p1)=new_threshold;
threshold(p2)=new_threshold;

newlabel = imagelabel;
newthreshold = threshold;

end