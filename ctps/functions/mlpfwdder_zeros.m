function [J] = mlpfwdder_zeros(net, xin)

%xin=ev.data;
%%
ye=mlpfwd(net,xin);
s2=size(xin,2);
der_dist=0.5;
for i=1:s2
    xin2=xin;
    xin2(:,i)=0;
    ye2=mlpfwd(net,xin2);
    J(:,i,:)=(ye-ye2)';
end
%%
end