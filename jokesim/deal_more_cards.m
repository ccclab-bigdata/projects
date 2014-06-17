function [hand,newdeck]=deal_more_cards(hand,deck,card_index)
ld=length(deck);
ind=find(card_index==0);
lind=length(ind);
for i=1:lind
    randind(i)=randi(ld,1);
    hand(ind(i))=deck(randind(i));
end
if lind>0
    newdeck=setxor(1:ld,randind);
else
    newdeck=deck;
end
end