function [J] = mlpfwdder_dist(net, xin)

%xin=ev.data;
%%
ye=mlpfwd(net,xin);
s2=size(xin,2);
der_dist=0.1;
for i=1:s2
    xin2=xin;
    xin2(:,i)=xin(:,i)+der_dist;
    ye2=mlpfwd(net,xin2);
    J(:,i,:)=(ye2-ye)';
end
%%
end