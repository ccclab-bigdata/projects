clc

[hand,deck]=make_random_hand(make_card_deck,5);
[out,card_index]=check_if_winning(hand);
for i=1:length(hand)
    lands(i)=hand(i).land;
    nums(i)=hand(i).num;
    
end
nums
lands
card_index


lands_hist=hist(lands,1:length(hand));
if sum(lands_hist==4)==1
    card_index(find(lands==find(lands_hist==4)))=1;
end



