mms='16mm';
%load(['../../../EmoMovies/movies_' mms '_20tps.mat'])


param.inds=1:size(D,3); % include all the voxels 
%param.inds=1:2; % include all the voxels 

param.Nw=25; % The number of the trials
param.mm=mms; % Extra info to be included in the output filenamess

param.Nb=4; % Number of blocks
param.Nsub=21; % Number of subjects
param.Nc=5; % Number of categories
param.regparam_mat=100; % A vector with different regularization parameters to try. Usually I have only one
%param.tp_mat=tp_vec; % A vector with the time points to run the classification
%param.calculate_jacobian=3; %3 none - 1 analytic - 2 distance - 3 zeros - 4 tp1 
param.calculate_jacobian=0; %3 none - 1 analytic - 2 distance - 3 zeros acts - 4 zero weights 0
param.calculate_jacobian_tr_set=0; %3 none - 1 analytic - 2 distance - 3 zeros - 4 tp1 
param.calculate_noep=0;

param.subjects=1:21;
param.subjects=2;
%D_or=D;
D=mean(D_or(:,:,:,5:8),4);
%D=mean(D(:,:,:,6:8),4);

param.tp_mat=1;

param.save_each_output=1;
%param.save_each_output=0;
param.nhidden_mat=20;
param.epochs=100;

param.calculate_jacobian=5;
out3=runall_fun(D,param);


%%
figure(1)
imagesc(squeeze(out.outgr(2,1,1,1,1,3,:,:)))


figure(2)
imagesc(squeeze(out.outgr2(2,1,1,1,1,3,:,:)))


figure(3)
clf

hold on
%plot(zscore(mean(squeeze(out.outgr2(2,1,1,1,1,3,:,:))')),'.r')
%plot(zscore(mean(squeeze(out.outgr(2,1,1,1,1,3,:,:))')),'.b')

ah=bar(zscore(mean(squeeze(out.outgr2(2,1,1,1,1,3,:,:))')),'EdgeColor','none','FaceColor','r')
ch = get(ah,'child');
set(ch,'facea',.5)

bh=bar(zscore(mean(squeeze(out.outgr(2,1,1,1,1,3,:,:))')),'EdgeColor','none','FaceColor','b')
ch = get(bh,'child');
set(ch,'facea',.5)


figure(4)
subplot(2,1,1)
hist(zscore(mean(squeeze(out.outgr2(2,1,1,1,1,3,:,:))')),100)
axis([-6 6 ylim])

title('correlated')
subplot(2,1,2)
hist(zscore(mean(squeeze(out.outgr(2,1,1,1,1,3,:,:))')),100)
axis([-6 +6 ylim])

title('independent')


figure(5)
subplot(2,1,1)
imagesc(corr(squeeze(out.outgr(2,1,1,1,1,3,:,:))'))
subplot(2,1,2)
imagesc(corr(squeeze(out.outgr2(2,1,1,1,1,3,:,:))'))
%%

% 
% param.prefix='./results_lin_nonlin/nonlin_';
% 
% for tpi=1
%     for subji=1
%     %param.subjects=subji;
%     param.subjects=1:21;
% param.tp_mat=tpi;
% out1=runall_fun(D,param);
%     end
% end
% %end
% 
% 
% param.nhidden_mat=0;
% param.prefix='./results_lin_nonlin/lin_';
% 
% for tpi=1
%     for subji=1
%     %param.subjects=subji;
%     param.subjects=1:21;
% param.tp_mat=tpi;
% out2=runall_fun(D,param);
%     end
% end
% 
% %%
% emoi=1;
% figure(1)
% temp1=squeeze(mean(out1.outgr(:,1,1,1,1,emoi,:,1:20),1));
% temp2=squeeze(mean(out2.outgr(:,1,1,1,1,emoi,:,1:20),1));
% subplot(2,1,1)
% imagesc(temp1(:,:));
% subplot(2,1,2)
% imagesc(temp2(:,:));
% 
% %%
% figure(2)
% clf
% plot(temp1,'.b','MarkerSize',20)
% hold on
% plot(temp2,'.r','MarkerSize',10)
% hold off
% 
% mask=load_nii(['../../emo_rois/whole_brain_' mms '_mask.nii']);
% f=find(mask.img==1);
% 
% newnii2=zeros(size(mask.img));
% newnii1=zeros(size(mask.img));
% 
% 
% newnii1(f)=zscore(mean(temp1'));
% newnii2(f)=zscore(mean(temp2'));
% 
% 
% naa(:,:,:,1)=newnii1;
% naa(:,:,:,2)=newnii2;
% 
% view_nii(make_nii(naa))
% 
% save_nii(upsample2mm(make_nii(newnii1),4),'hns.nii')
% save_nii(upsample2mm(make_nii(newnii2),4),'nohns.nii')
% 
% %%
% 
% niii=load_nii('../../activations_diffs/EmoMovies/emo1.nii');
% save_nii(make_nii(niii.img(:,:,:,7)),'acts.nii');
% 
% niii=load_nii('../../activations_diffs/EmoMovies/emo2.nii');
% save_nii(make_nii(niii.img(:,:,:,7)),'acts2.nii');
% 
% niii=load_nii('../../activations_diffs/EmoMovies/emo3.nii');
% save_nii(make_nii(niii.img(:,:,:,7)),'acts3.nii');