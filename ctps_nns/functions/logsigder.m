function [ Y ] = logsigder( X )
%LOGSIGDER Summary of this function goes here
%   Detailed explanation goes here
Y=logsig(X).*(1-logsig(X));

end

