function [out,card_index]=check_if_winning(hand)
% 1: one pair
%
%
%
card_index=zeros(length(hand),1)';
for i=1:length(hand)
    lands(i)=hand(i).land;
    nums(i)=hand(i).num;
    
end

out=0;

%% One-two pair(s)
pair=0;
for i=1:13
    if sum(nums==i)==2
        card_index=card_index+(nums==i);
        pair=pair+1;
    end
end

%% Three of a kind

threeokind=0;
for i=1:13
    if sum(nums==i)==3
        card_index=nums==i;
        threeokind=1;
    end
end

%% Straight
straight=0;
if sum(nums-min(nums))==10 && pair==0
   card_index=ones(length(hand),1)';
    
   straight=1; 
end


%% Full House
fullhouse=0;
if threeokind==1 && pair>0
   fullhouse=1; 
   card_index=ones(length(hand),1)';
end


%% Flush
flush=0;
if min(lands)==max(lands)
    flush=1;
    card_index=ones(length(hand),1)';
end

%% Four of a kind
kare=0;
for i=1:13
    if sum(nums==i)==4
        kare=1;
        card_index=nums==i;
    end
end

%% Flos

flos=0;
if straight==1 && flush==1;
    flos=1;
    card_index=ones(length(hand),1)';
end



%% Mappings to output

%if pair==1;
    %out=1;
%end
if pair==2;
    out=1;
end

if threeokind==1;
    out=2;
end

if straight==1;
    out=3;
end

if fullhouse==1;
    out=4;
end

if flush==1
    out=5;
end



if kare==1;
    out=6;
end

if flos==1;
    out=7;
end

end