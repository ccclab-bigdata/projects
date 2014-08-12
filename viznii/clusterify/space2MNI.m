
function [xMNI,yMNI,zMNI] = space2MNI(x,y,z)
    xMNI = 2*((x-1)-45);
    yMNI = 216*(y-1)/108 - 126;
    zMNI = 180*(z-1)/90 - 72;
end   