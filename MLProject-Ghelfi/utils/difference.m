function [diff] = difference(Xts, Yts, Ypred)
%DIFF Summary of this function goes here
%   Detailed explanation goes here
    diff = Xts(Yts ~= Ypred, :);
end

