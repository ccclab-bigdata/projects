function [J] = mlpfwdder_an(net, xin)

nhidden=net.nhidden;
nout=net.nout;
nin=net.nin;

for datai=1:size(xin)
    x=xin(datai,:);

a1=net.w1'*x'+net.b1';



a2=tanh(a1'*net.w2+net.b2);


for ki=1:net.nout
    
    delta=zeros(nout,1);
    delta(ki)=1;
    t2(ki,:)=net.w2(:,:)*logsigder(a2(ki))*delta(:); % it sums the 2-length vector

    t1=(net.w1.*repmat(tanhder(a1(:)),1,nin)').*repmat(t2(ki,:),nin,1);
    J(ki,:,datai)=sum(t1');

end
end
end