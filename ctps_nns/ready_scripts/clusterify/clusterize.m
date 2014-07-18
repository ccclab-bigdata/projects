function resultTH=clusterize(nii,opts)
% returns a nii struct with the clusters in the input nii structure.
% First argument is the input nii file
% Second argument is an options struct:
%       th_l:     the negative threshold (default: -1)
%       th_r:     the positive threshold (default: 1)
%       min_clust_size:     the minimum cluster size allowed (default: 100)
%       verbose:     giving information about the clusters (default: 100)
%       prefix: a string to be used as prefix in the saved csv files.
% If there is a folder in the current directory called csvs then the
% cluster lists are saved there in csv format.

if exist('csvs')~=7
    display('Directory csvs does not exist; Files will not be saved');
    display('Press any key...');
    pause;
end

if isfield(opts,'th_r')~=1
   opts.th_r=1;
   display('Positive threshold set to 1 since not defined.');
end


if isfield(opts,'th_l')~=1
   opts.th_l=-1;
   display('Negative threshold set to -1 since not defined.');
end

if isfield(opts,'min_clust_size')~=1
   opts.min_clust_size=100;
   display('Minimum cluster size set to 100 since not defined.');
end

if isfield(opts,'verbose')==0
   opts.verbose=1;
   display('Verbose mode set to on since not defined.');
end

if isfield(opts,'prefix')~=1
   opts.prefix='';
   display('CSV file prefix not defined.');
end

th_l=opts.th_l;
th_r=opts.th_r;

results=nii.img;

for f=1:size(results,4)	% if we have many volulmes
	temp=results(:,:,:,f);
	temp(intersect(find(temp<=th_r),find(temp>=0)))=0;
	temp(intersect(find(temp>=th_l),find(temp<=0)))=0;
	mask=clusterit(abs(sign(temp)),0,opts.min_clust_size);
	resultTH(:,:,:,f)=temp.*sign(mask);
	outp{f}=getallstats(resultTH(:,:,:,f),1,opts);
	outn{f}=getallstats(resultTH(:,:,:,f),-1,opts);
        if exist('csvs')==7
            csvwrite(['csvs/' opts.prefix 'blobs_tp' num2str(f) '_p.csv'],outp{f});
            csvwrite(['csvs/' opts.prefix 'blobs_tp' num2str(f) '_n.csv'],outn{f});
        end
end

end