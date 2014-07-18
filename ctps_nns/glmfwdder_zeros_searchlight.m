function [J] = glmfwdder_zeros_searchlight(net, xin, vox)

%xin=ev.data;
%%
ye=glmfwd(net,xin);
s2=size(xin,2);
der_dist=0.5;
net2=net;
for i=1:s2
    net2.w1(vox(i).inds,:)=0;
    %display(['the index ' num2str(i) ' net ws: ' num2str(length(net2.w1)) ' length of vox ' num2str(length(vox(i).inds))])
    ye2=glmfwd(net2,xin);
    net2.w1=net.w1;
    J(:,i,:)=(ye-ye2)'/length(vox(i).inds);
end
%%
end