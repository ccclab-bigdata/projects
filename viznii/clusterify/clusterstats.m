function out=clusterstats(mask,img,opts) % wants a mask with cluster IDs, 0 outsside
out=[];
ids=unique(mask(:));
if(ids(1)~=0)
       error('wtf')
end
if opts.verbose==1;
disp(['Cluster ID | Size | x | y | z | max value'])
end
id_ind=2;
for i=2:length(ids)
    id=ids(i);
    M=find(mask==id);
    S=length(M);    % number of voxels in the cluster
    Mmax=M(find(max(abs(img(M)))==abs(img(M)))); % we need the abs since they could be negative
    [x y z]=ind2sub(size(mask),Mmax(1));
	[allx ally allz]=ind2sub(size(mask),M);
    [xMNI,yMNI,zMNI] = space2MNI(x,y,z);

	mx=round(mean(allx));
	my=round(mean(ally));
	mz=round(mean(allz));
	[mxMNI, myMNI, mzMNI] = space2MNI(mx,my,mz);	

    if(S<opts.min_clust_size)
        continue
    end
    
    out=[out;
        id_ind-1 S xMNI yMNI zMNI img(Mmax(1)) mxMNI myMNI mzMNI];
    if opts.verbose==1;
        disp([num2str(id_ind-1) ' | ' num2str(S) ' | ' num2str(xMNI) ' | ' num2str(yMNI) ' | ' num2str(zMNI) ' | ' num2str(img(Mmax(1))) ' | ' num2str(mxMNI) ' | ' num2str(myMNI) ' | ' num2str(mzMNI) ]);
    end
    id_ind=id_ind+1;
end
