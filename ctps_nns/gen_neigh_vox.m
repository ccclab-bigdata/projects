function vox=gen_neigh_vox(radiuss,mms)

nii=load_nii(['../emo_rois/whole_brain_' mms '_mask.nii']);
f=find(nii.img==1);

s=size(nii.img);
[x,y,z]=ind2sub(s,f);


%%

%newimg=zeros(size(nii.img));

%radius=4;

radius=radiuss;


%for i=2500

%padding=2

img=zeros((radius*2+1),(radius*2+1),(radius*2+1));
for xi=-radius:radius
    for yi=-radius:radius
        for zi=-radius:radius
            if xi^2+yi^2+zi^2<radius^2
                img(xi+radius,yi+radius,zi+radius)=1;
                %newimg(xi+center(1),yi+center(2),zi+center(3))=1;
            end
        end
    end
end

for i=1:length(f)
%for i=853
    center=[x(i) y(i) z(i)];
    newimg=zeros(size(nii.img));
    
    xinds=(center(1)-radius):(center(1)+radius);
    yinds=(center(2)-radius):(center(2)+radius);
    zinds=(center(3)-radius):(center(3)+radius);
    
    newimg(xinds(and(xinds>0, xinds<=s(1))),yinds(and(yinds>0,yinds<=s(2))),zinds(and(zinds>0,zinds<=s(3))))=img(xinds(and(xinds>0,xinds<=s(1)))-center(1)+radius+1,yinds(and(yinds>0,yinds<=s(2)))-center(2)+radius+1,zinds(and(zinds>0,zinds<=s(3)))-center(3)+radius+1);
    %vox(i).inds=f(find(newimg(f)==1));
    vox(i).inds=find(newimg(f)==1);
    vox(i).center=center;
    %view_nii(make_nii(newimg));
    %pause;
    %clear newimg
end


%view_nii(make_nii(img))

end