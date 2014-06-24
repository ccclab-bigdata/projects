function [output_struct,net]=runall_fun(D_or,param)
% This function runs intersubject classification with LOO cross-validation
% The input data is in in D_or in the form of
% subject,block,hiddenlayers,timepoint, reg_param
Nb=param.Nb;
inds=param.inds;
if ~isfield(param,'regparam_mat_comm')
    committee=1;
end

if ~isfield(param,'calculate_noep')
    param.calculate_noep=0;
end

if ~isfield(param,'calculate_jacobian')
    param.calculate_jacobian=0;
end

if ~isfield(param,'prefix')
    param.prefix='';
end

if ~isfield(param,'subjects')
    param.subjects=1:param.Nsub;
end


for regparami=1:length(param.regparam_mat);
    if committee==1
        param.regparam_mat_comm=param.regparam_mat(regparami);
    end
    display(['Regularization parameter: ' num2str(param.regparam_mat(regparami))])
    for tpi=1:length(param.tp_mat);
        datai=param.tp_mat(tpi);
        
        D=D_or(:,:,:,datai);
        D1=D_or(:,:,:,1);
        
        
        
        
        for nhi=1:length(param.nhidden_mat)
            
            param.nhidden=param.nhidden_mat(nhi);
            for subji=param.subjects
                
                for bli=1
                    
                    %%
                    all_bl=((subji-1)*Nb+1):((subji-1)*Nb+Nb);
                    blk=bli+(subji-1)*Nb;
                    
                    % ev_set=blk;
                    % tr_set=setxor(all_bl,blk);
                    tr_set=setxor(1:param.Nb*param.Nsub,all_bl);
                    ev_set=all_bl;
                    
                    display(['Subject no: ' num2str(subji)]);
                    display(['Time point: ' num2str(tpi)]);
                    
                    
                    %display(['Training set: ' num2str(tr_set)])
                    
                    
                    display(['Number of voxels: ' num2str(length(inds))])
                    if ~isfield(param,'y')
                        y=make_targs_labels(param);
                    else
                        y=param.y;
                    end
                    
                    %[tr1,ev1]=get_cross_val_data(D1,y,inds,tr_set,ev_set,0);
                    [tr,ev]=get_cross_val_data(D,y,inds,tr_set,ev_set,0);
                    
                    
                    % Train the nn
                    
                    
                    
                    [out,net]=nn_train_and_ev(tr,ev,param,ev);
                    
                    output_struct.ye(subji,bli,nhi,tpi,regparami,:,:)=out.ye;
                    %output_struct.tr(subji,bli,nhi,tpi,regparami,:,:)=tr.data;
                    %output_struct.ev(subji,bli,nhi,tpi,regparami,:,:)=ev.data;
                    
                    
                    
                    if param.calculate_jacobian~=0
                    output_struct.outgr(subji,bli,nhi,tpi,regparami,:,:,:)=out.outgr;
                    
                    if param.calculate_jacobian==5
                    output_struct.outgr2(subji,bli,nhi,tpi,regparami,:,:,:)=out.outgr2;
                    end
                    end
                    
                    if param.calculate_jacobian_tr_set~=0
                    output_struct.outgr_tr(subji,bli,nhi,tpi,regparami,:,:,:)=out.outgr_tr;
                    end
                    
                    
                    if param.calculate_noep==1
                    output_struct.noep(subji,bli)=out.noep;
                    end
                    
                    [mat,p]=confmat(out.ye,ev.y);
                    display(['Importance method : ' num2str(param.calculate_jacobian)]);
                    display(['Subject acccuracy : ' num2str(p(1))]);
                    display(' ');
                    display(' ');
                    output_struct.performance(subji,bli,nhi,tpi,regparami,:,:)=mat;
                    output_struct.perf(subji,bli,tpi,regparami)=p(1);
                    
                    
                    
                end
            end
        end
    end
end
if isfield(param,'save_each_output')
    if param.save_each_output==1;
        save([param.prefix 'output_struct_' param.mm '_' num2str(length(param.inds)) 'voxels_tp' num2str(param.tp_mat) '.mat'],'output_struct','param','-v7.3')
    end
    
end
end