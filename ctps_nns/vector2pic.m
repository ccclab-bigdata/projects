function newimg=vector2pic(xin,mms,varargin)

if nargin<3
    mask=load_nii(['./emo_rois/whole_brain_' mms '_mask.nii']);
else
    
    mask=load_nii(varargin{1});
end
    f=find(mask.img==1);

newimg=zeros(size(mask.img));
newimg(f)=xin;
end
    
