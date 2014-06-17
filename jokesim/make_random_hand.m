function [hand,newdeck]=make_random_hand(deck,nocards)
%%
newdeck=deck;
for i=1:nocards
    lnd=length(newdeck);
    index(i)=randi(lnd,1);
    
    hand(i)=newdeck(index(i));
    newdeck=newdeck(setxor(index(i),1:lnd));
end

%newdeck=deck(setxor(index,1:52));

