function [J] = glmfwdder_zeros2(net, xin)

%xin=ev.data;
%%
ye=glmfwd(net,xin);
s2=size(xin,2);
der_dist=0.5;
net2=net;
for i=1:s2
    net2.w1(i,:)=0;
    ye2=glmfwd(net2,xin);
    net2.w1=net.w1;
    J(:,i,:)=(ye-ye2)';
end
%%
end