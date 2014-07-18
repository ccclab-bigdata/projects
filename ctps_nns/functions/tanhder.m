function [ Y ] = tanhder( X )
%TANHDER Summary of this function goes here
%   Detailed explanation goes here
Y=1./(cosh(X).^2);

end

