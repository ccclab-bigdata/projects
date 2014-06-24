function out=classify_function_movies(tp_vec,mms)



load(['../../../EmoMovies/movies_' mms '_20tps.mat'])


param.inds=1:size(D,3); % include all the voxels 
%param.inds=1:2; % include all the voxels 

param.Nw=25; % The number of the trials
param.mm=mms; % Extra info to be included in the output filenamess

param.Nb=4; % Number of blocks
param.Nsub=21; % Number of subjects
param.Nc=5; % Number of categories
param.regparam_mat=100; % A vector with different regularization parameters to try. Usually I have only one
param.tp_mat=tp_vec; % A vector with the time points to run the classification
%param.calculate_jacobian=3; %3 none - 1 analytic - 2 distance - 3 zeros - 4 tp1 
param.calculate_jacobian=3; %3 none - 1 analytic - 2 distance - 3 zeros - 4 tp1 
param.calculate_jacobian_tr_set=0; %3 none - 1 analytic - 2 distance - 3 zeros - 4 tp1 
param.calculate_noep=0;
param.subjects=1:21;
%D=mean(D_or(:,:,:,6:7),4);
%D=mean(D(:,:,:,6:8),4);


param.nhidden_mat=20;
param.save_each_output=1;
%param.save_each_output=0;
param.prefix='./results_with_jaco/';

%%
param.epochs=100;
%for tpi=1:20
%param.tp_mat=tpi;

%param=catstruct(param,param1);
out=runall_fun(D,param);
%end

end