function [ tr,ev ] = get_cross_val_data( D,y1,ind,tr_set,ev_set,varargin )
%GET_CROSS_VAL_DATA_INTRASUBJECT_WORDS Summary of this function goes here
%   Detailed explanation goes here
datai=5;
Nc=size(y1,3);

if nargin>2
    
    tp=varargin{1};
    if tp>0
    D1=permute(squeeze(D(:,:,ind,tp)),[2 1 3]);
    else
        D1=permute(squeeze(mean(D(:,:,ind,:),4)),[2 1 3]);

    end
    
    
else
D1=permute(squeeze(mean(D(:,:,ind,:),4)),[2 1 3]);

end
%D1=permute(squeeze(D(:,:,ind,datai)),[2 1 3]);
Nv=size(D1,3);
D2tr=D1(tr_set,:,:);
y2tr=y1(tr_set,:,:);

D2ev=D1(ev_set,:,:);
y2ev=y1(ev_set,:,:);



tr.y=reshape(y2tr,size(y2tr,1)*size(y2tr,2),Nc);
tr.data=reshape(D2tr,size(D2tr,1)*size(D2tr,2),Nv);

ev.y=reshape(y2ev,size(y2ev,1)*size(y2ev,2),Nc);
ev.data=reshape(D2ev,size(D2ev,1)*size(D2ev,2),Nv);


end

