function [ out_nii ] = fix_mni( in_nii )
%FIX_MNI
% This function fixes the header of the nii file to register it in MNI
% space using a reference nii file

[~,name]=system('hostname')
if strcmp(name(1:4),'fn01')
    prefix_path='/triton/becs/';
elseif strcmp(name(1:4),'fn02')
    prefix_path='/triton/becs/';
else
    prefix_path='';
end



ref=load_nii([prefix_path '/scratch/braindata/gostopa1/emo_rois/fix_mni.nii']);


out_nii=in_nii;
out_nii.hdr.dime.pixdim = ref.hdr.dime.pixdim;
out_nii.hdr.dime.scl_slope = ref.hdr.dime.scl_slope;
out_nii.hdr.dime.xyzt_units = ref.hdr.dime.scl_slope;
out_nii.hdr.hist = ref.hdr.hist;


out_nii.original.hdr.dime.pixdim = ref.original.hdr.dime.pixdim;
out_nii.original.hdr.dime.scl_slope = ref.original.hdr.dime.scl_slope;
out_nii.original.hdr.dime.xyzt_units = ref.original.hdr.dime.scl_slope;
out_nii.original.hdr.hist = ref.original.hdr.hist;


end

