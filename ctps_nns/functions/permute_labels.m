function y2=permute_labels(y)

sy=size(y);
for i=1:sy(1)
    for j=1:sy(2)
        y2(i,j,:)=y(i,j,randperm(sy(3)));
    end
end

end