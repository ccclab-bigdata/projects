function show_hand(hand)



for i=1:length(hand)
    lands(i)=hand(i).land;
    nums(i)=hand(i).num;
    
end
display(num2str(nums,2))
display(num2str(lands,2))

end