function out=getallstats(img,segno,opts)

if(segno==1)
    disp('positive clusters')
    [x y z]=ind2sub(size(img),find(img>0));
    %length(x)
else
    disp('negative clusters')
    [x y z]=ind2sub(size(img),find(img<0));
     %   length(x)
end
a=[x y z];
clust=spm_clusters(a');
newmask=zeros(size(img));
for c = 1:length(clust);
	cids=find(c==clust);
    csize=length(cids);
		for cc=1:length(cids)
        		newmask(a(cids(cc),1),a(cids(cc),2),a(cids(cc),3))=c;
		end
   
end

out=clusterstats(newmask,img,opts);
