function newimg=vector2pic(xin,mms)


mask=load_nii(['./emo_rois/whole_brain_' mms '_mask.nii']);
    f=find(mask.img==1);

newimg=zeros(size(mask.img));
newimg(f)=xin;
end
    
