function [ y1 ] = make_targs_labels( param )
%MAKE_TARGS_WORDS Summary of this function goes here
%   Detailed explanation goes here



Nsub=param.Nsub;
Nb=param.Nb;
Nw=param.Nw;
Nc=param.Nc;
y1=zeros(Nb*Nsub,Nw,Nc);
for i=0:(Nc-1)
y1(1:Nb*Nsub,((i*Nc)+1):((i*Nc)+Nc),(i+1))=1;
end

% y1(1:Nb*Nsub,1:6,1)=1;
% y1(1:Nb*Nsub,7:12,2)=1;
% y1(1:Nb*Nsub,13:18,3)=1;
% y1(1:Nb*Nsub,19:24,4)=1;
% y1(1:Nb*Nsub,25:30,5)=1;
% y1(1:Nb*Nsub,31:36,6)=1;

%y=reshape(y1,Nb*Nsub*Nw,6);

end

