function [J]=mlpfwd_der_zeros_corr(net, xin)


ye=mlpfwd(net,xin);
C=cov(xin);
s=size(xin);
inds=1:s(2);



mxin=mean(xin)';

%ynew=zeros(s(2),1);
%ynew(yinds)=(mxin(yinds)-C(yinds,xinds)*(0-mxin(xinds)));



for i=1:s(2)
    
    xinds=i;
    yinds=setxor(inds,i);
    
    xin2=zeros(s(1),s(2));
    xin2(:,yinds)=xin(:,yinds)+(C(yinds,xinds)*(zeros(s(1),1)-xin(:,xinds))')';

    ye2=mlpfwd(net,xin2);
    J(:,i,:)=(ye-ye2)';
end

end