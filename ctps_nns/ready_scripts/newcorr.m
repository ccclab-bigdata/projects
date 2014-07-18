function [ res ] = newcorr( mat )
%NEWCORR Calculating correlation by assumming that the mean is zeros (for z-scored data)


res=mat*mat';
res=res./max(res(:));

end

