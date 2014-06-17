clear out
for iters=1:200
    iters
for i=1:100

deck=make_card_deck;



[hand,deck]=make_random_hand(deck,5);



[out(i),card_index]=check_if_winning(hand);
card_index=smart_index(hand,card_index);
% display('First deal')
% show_hand(hand)
% display(num2str(card_index,2))
% display(' ')

[hand,deck]=deal_more_cards(hand,deck,card_index);
[out2(i,iters),card_index]=check_if_winning(hand);

% display('Second deal')
% show_hand(hand)
% display(num2str(card_index,2))
% display(' ')

if out(i)>70
    
    pause
end


end
ps(iters)=sum(out2(:,iters)>1)/length(out2(:,iters));
end
ps_smart=ps;


%hist(out,5)
%hist(out2,[0:10])

hist(ps,40)

%%
% for i=9800:9900
% 
%     display(' ');
%     display(sprintf('%s',i));
%     display(num2str(i));
% end

%%
nobins=40
subplot(2,1,1)
hist(ps_dumb,nobins)
axis([0 1 ylim])
subplot(2,1,2)
hist(ps_smart,nobins)

axis([0 1 ylim])