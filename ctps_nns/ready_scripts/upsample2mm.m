function [newnii]=upsample2mm(nii1,fold)
%% This function takes a downsampled nii image and upsamples it to the original MNI space (2mm) using spline interpolation.
% The input is the filename of the nii file to be upsampled
% It is upsampled based on the HarvardOxford standard MNI152_2mm located in
% /scratch/braindata/gostopa1/HarvardOxford/testfslupsampling/MNI152_T1_2mm.nii
% It is also registered to the MNI space using the fix_mni function.
% 
prefix=[];
[~, name] = system('hostname');
if strcmp(name(1:4),'fn01')
    prefix='/triton/becs';
end
    
 nii2=load_nii([prefix '/scratch/braindata/gostopa1/HarvardOxford/testfslupsampling/MNI152_T1_2mm.nii']);

% nii1=load_nii(filename);
for tpi=1:size(nii1.img,4)
s1=size(nii1.img);

s2=size(nii2.img);
newimg=zeros(size(nii2.img));

%step=4;
step=fold;
%step=2;

vol=squeeze(double(nii1.img(:,:,:,tpi)));
[gX,gY,gZ] = meshgrid(1:step:s2(1),1:step:s2(2),1:step:s2(3));
vol2=permute(vol,[2 1 3]);
% gX=1:step:s2(1);
% gY=1:step:s2(2);
% gZ=1:step:s2(3);
[bgX, bgY,bgZ] = meshgrid(1:s2(1),1:s2(2),1:s2(3));
voli=interp3(gX,gY,gZ,vol2,bgX,bgY,bgZ,'linear');
      
      vol3=permute(voli,[2 1 3]);
      
      newnii.img(:,:,:,tpi)=smooth3(vol3,'box',3);
end
      newnii=fix_mni(make_nii(newnii.img));
      newnii.hdr.dime.pixdim(2:4)=2;
      newnii.hdr.dime.pixdim=[1 2 2 2 1 0 0 0];
end