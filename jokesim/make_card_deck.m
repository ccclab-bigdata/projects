function deck=make_card_deck
%%
ind=1;
for i=1:4
    for j=1:13
        deck(ind).num=j;
        deck(ind).land=i;
        ind=ind+1;
    end
end



%%
end