function [ x,y,z ] = get_coords( mask )
% Gives the coordinates of the the mask voxels in a x y z format.

[x,y,z]=ind2sub(size(mask.img),find(mask.img==1));

end

