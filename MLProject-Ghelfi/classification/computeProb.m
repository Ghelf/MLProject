function [probs] = computeProb(Xtr, Ytr, numC)
%COMPUTEPROB Summary of this function goes here
%   Detailed explanation goes here
    [n, d] = size(Xtr);
    [count, ~] = size(Ytr(Ytr == numC));
    probs = zeros(n, d);
    %For each dimension, pick the unique vars 
    for i = 1:d
        %For each dimension, pick the unique vars and count how many they
        %are.
        vars = unique(Xtr(Ytr == numC, i))
        [v, ~] = size(vars);
        for j = 1:v
            %For each unique var, find the ones that may belong to
            %class numC in the main dataset.
            varGroup = Xtr(Ytr == numC, i);
            [varcount, ~] = size(varGroup(varGroup == j, :));
            p = varcount/count;
            for k = 1:n
                if Xtr(k, i) == j
                    if Ytr(k) == numC
                        probs(k, i) = p;
                    end
                end
            end
        end
    end
end

