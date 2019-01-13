function [res] = getReponseMaj(counts)
%GETREPONSEMAJ Summary of this function goes here
%   Detailed explanation goes here
    [~, idx] = min(counts);
    if size(idx) == 1
        if idx == 2 || idx == 3
            res = 1;
        else
            res = 2;
        end
    end
end

