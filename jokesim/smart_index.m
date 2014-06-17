function card_index=smart_index(hand,card_index)
%
for i=1:length(hand)
    lands(i)=hand(i).land;
    nums(i)=hand(i).num;
    
end

ld=length(hand);


%% If only one card of that land and quite distant - Alone seems to deteriorate the results 

% dists=zeros(ld,1);
% for i=1:ld
%     for j=1:ld
%         
%         dists(i)=abs(nums(i)-nums(j));
%         
%     end
% end
% [md,indd]=max(dists);
% 
% 
% if sum(lands==indd)==1 && md/mean(dists)>3
%     card_index(indd)=1;
% end


%% If there are four of the same land keep them

lands_hist=hist(lands,1:length(hand));
if sum(lands_hist==4)==1
    card_index(find(lands==find(lands_hist==4)))=1;
end



%%

end
