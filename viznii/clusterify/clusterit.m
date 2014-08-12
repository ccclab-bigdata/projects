function newmaskFinal=clusterit(mask,split,min_clust_size)
% first run through cluster: cleans small isolated clusters of less than
% 5*5*5 voxels

[x y z]=ind2sub(size(mask),find(mask==1));
a=[x y z];
clust=spm_clusters(a');
newmask=zeros(size(mask));
for c = 1:length(clust);
	cids=find(c==clust);
    csize=length(cids);
	%disp(['% ' num2str(100*c/length(clust))])
    if(csize<(min_clust_size))
		for cc=1:length(cids)
          		mask(a(cids(cc),1),a(cids(cc),2),a(cids(cc),3))=0;
		end
	else
		for cc=1:length(cids)
        		newmask(a(cids(cc),1),a(cids(cc),2),a(cids(cc),3))=c;
		end
    end
end


if(split==0)
    newmaskFinal=newmask;
else

% removes points of the remaining clusters. If a point has less than
% THRESHOLD neihbours belonging to the same cluster, is left out of the
% cluster

for x=2:90
    disp(num2str(x))
    for y = 2:108;
        for z = 2:90;
            count = 0;
            point=newmask(x,y,z);
            if(point == 0)
                continue
            end
            count=count+length(find(newmask(x,y-1:y+1,z-1:z+1)==point))-1;
            count=count+length(find(newmask(x-1:x+1,y,z-1:z+1)==point))-1;
            count=count+length(find(newmask(x-1:x+1,y-1:y+1,z)==point))-1;
            
            if(count<20)        % CHANGE THRESHOLD HERE
                mask(x,y,z)=0;
            else
                mask(x,y,z)=1;
            end
        end
    end
end

% recomputes the clustering with the new cleaned volume

[x y z]=ind2sub(size(mask),find(mask==1));
a=[x y z];
clust=spm_clusters(a');
newmaskFinal=zeros(size(mask));
goodclus=1;
for c = 1:length(clust);
	cids=find(c==clust);
    csize=length(cids);
	disp(['% ' num2str(100*c/length(clust))])
    if(csize<(min_clust_size))
        for cc=1:length(cids)
            mask(a(cids(cc),1),a(cids(cc),2),a(cids(cc),3))=0;
		end
	else
		for cc=1:length(cids)
        		newmaskFinal(a(cids(cc),1),a(cids(cc),2),a(cids(cc),3))=goodclus;
        end
        goodclus=goodclus+1;
   end
end

end
