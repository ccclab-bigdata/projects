%%


anii.img=nii.img(:,:,:,8:9);
%thres=0.5;
%anii.img(anii.img<thres)=0;
inds=find(img>thres);
[x y z]=ind2sub(size(img),inds);

a=[x y z];

newimg=zeros(size(anii.img));




th_r=0.0005;
th_l=-0.0005;

%newimg(inds)=clust;
%view_nii(make_nii(newimg))

results=anii.img;

for f=1:size(results,4)	% if we have many volulmes
	temp=results(:,:,:,f);
	temp(intersect(find(temp<=th_r),find(temp>=0)))=0;
	temp(intersect(find(temp>=th_l),find(temp<=0)))=0;
	mask=clusterit(abs(sign(temp)),0);
	resultTH(:,:,:,f)=temp.*sign(mask);
	outp{f}=getallstats(resultTH(:,:,:,f),1);
	outn{f}=getallstats(resultTH(:,:,:,f),-1);
	csvwrite(['csvs/blobs_tp' num2str(f) '_p.csv'],outp{f});
	csvwrite(['csvs/blobs_tp' num2str(f) '_n.csv'],outn{f});
end