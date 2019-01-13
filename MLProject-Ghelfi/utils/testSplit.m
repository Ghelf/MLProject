function [Xtr,Ytr,Xts,Yts] = testSplit(Xtr, Ytr, percTs)
%This function provides a random splitting of a dataset.
%   Input parameters:
%       - X => the inputs;
%       - numC => the labels;
%       - percTs => the test set percentage;
%   Output:
%       - Xtr => the training set (1-percTs, d).
%       - Ytr => the training labels (1-percTs, 1);
%       - Xts => the test set (percTs, d).
%       - Yts => the test labels (percTs, 1);

    if (percTs > 1 || percTs < 0)
        fprintf('percTs has to be grater than %d smaller than %d', 0, 1);
        return;
    end
    
    [n, ~] = size(Xtr);
    numTs = floor(n * percTs);
    
    extract = zeros(numTs, 1);
    for i = 1:numTs
        ex = randi(n);
        while(ismember(ex, extract))
            ex = randi(n);
        end
        extract(i) = ex;
    end
    
    Xts = Xtr(extract, :);
    Xtr(extract, :) = [];
    Yts = Ytr(extract, :);
    Ytr(extract, :) = [];
      
end

