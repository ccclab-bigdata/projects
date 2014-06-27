function [out,net ] = nn_train_and_ev( tr,ev,param,ev1 )
%NN_TRAIN_AND_EV Summary of this function goes here
%   Detailed explanation goes here

if isfield(param,'beta')
    beta=param.beta;
else
    beta=1;
end

if isfield(param,'regparam')
    reg_par=param.regparam;
else
    reg_par=1;
end

if isfield(param,'nhidden')
    nhidden=param.nhidden;
else
    nhidden=5;
end

if isfield(param,'epochs')
    epochs=param.epochs;
else
    epochs=50;
end

display(['No hidden layers: ' num2str(nhidden)])
if isfield(param,'regparam_mat_comm')
for i=1:length(param.regparam_mat_comm);
    reg_par=param.regparam_mat_comm(i);
display(['Beta: ' num2str(beta)])
display(['Regularization parameter: ' num2str(reg_par)]);

%prior = mlpprior(size(tr.data,2), nhidden , size(tr.y,2), aw1,ab1,aw2,ab2);

%net = mlp(size(tr.data,2), nhidden ,size(tr.y,2), 'logistic',prior); 
if nhidden>0;
net = mlp(size(tr.data,2), nhidden ,size(tr.y,2), 'logistic',reg_par,beta); 
else
net = glm(size(tr.data,2) ,size(tr.y,2), 'logistic',reg_par,beta); 
end
% Set up vector of options for the optimiser. 
options = zeros(1,18); 
options(1) = 0;            % This provides display of error values. 
options(9) = 0;            % Check the gradient calculations. 
%options(14) = 300;
options(14) = epochs;        % Number of training cycles.     
% Train using scaled conjugate gradients. 


if nhidden>0;
    [net, options] = netopt(net, options, tr.data, tr.y, 'scg'); 
else
    
    
    options(5)=1;
    [net, options] = netopt(net, options, tr.data, tr.y, 'scg'); 
    %[net, options] = glmtrain(net, options, tr.data, tr.y);
    
    
end



w = netpak(net);
% Evaluate data-dependent contribution to the Hessian matrix.
if param.calculate_noep==1
tic
    %[h, dh] = nethess(w, net, tr.data, tr.y); 
    [h, dh] = mlphess(net, tr.data, tr.y); 
display(['Hess time: ' num2str(toc)])
out.h=h;
tic
eigh=eig(h);

display(['Eigs time: ' num2str(toc)])
out.noep=sum(eigh./(reg_par+eigh));
end


if nhidden>0
out.ye_comm(i,:,:)=mlpfwd(net,ev.data);
else
    out.ye_comm(i,:,:)=glmfwd(net,ev.data);
end
end
out.ye=squeeze(mean(out.ye_comm,1));



%out.outgr=mlpfwdder2(net,ev.data);
%out.outgr_dist=mlpfwdder_dist(net,ev.data);
if nhidden>0
switch param.calculate_jacobian
    case 1
    out.outgr=mlpfwdder2(net,ev.data);    
    case 2
        out.outgr=mlpfwdder_dist(net,ev.data);    
    case 3
        out.outgr=mlpfwdder_zeros(net,ev.data);
    case 4
        out.outgr=mlpfwdder_zeros2(net,ev.data);
    case 5
        out.outgr=mlpfwdder_zeros2(net,ev.data);
        out.outgr2=mlpfwd_der_zeros_corr(net,ev.data)
end

else
switch param.calculate_jacobian
    case 1
        out.outgr=glmfwdder2(net,ev.data);    
    case 2
        out.outgr=glmfwdder_dist(net,ev.data);    
    case 3
        out.outgr=glmfwdder_zeros(net,ev.data);
    case 4
        out.outgr=glmfwdder_zeros2(net,ev.data);
        
end
end


if nhidden>0
    
switch param.calculate_jacobian_tr_set
    case 1
    out.outgr_tr=mlpfwdder2(net,tr.data);    
    case 2
        out.outgr_tr=mlpfwdder_dist(net,tr.data);    
    case 3
        
        out.outgr_tr=mlpfwdder_zeros(net,tr.data);
    case 4
        out.outgr_tr=mlpfwdder_zeros2(net,tr.data);
    case 5
        
        
end

else
    switch param.calculate_jacobian_tr_set
    case 1
    out.outgr_tr=glmfwdder2(net,tr.data);    
    case 2
        out.outgr_tr=glmfwdder_dist(net,tr.data);    
    case 3
        out.outgr_tr=glmfwdder_zeros(net,mean(tr.data));
    case 4
        out.outgr_tr=glmfwdder_zeros2(net,tr.data);
end
end
%pause
end
    

%%
end

