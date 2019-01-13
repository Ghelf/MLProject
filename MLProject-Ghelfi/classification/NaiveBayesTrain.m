function [mean, variance, classProb] = NaiveBayesTrain(Xtr, Ytr)
%This Naive Bayes algorithm is based on the assumption of a gaussian
%probability of the data and computes a binary classification.
%   Input parameters:
%       - Xtr => the training set;
%       - Ytr => the labels;
%   Outputs:
%       - mean => a dx2 matrix containing the mean for each dimension, 
%                 for both the possible responses (positive and negative);
%       - variance => a dx2 matrix containing the variance for each 
%                   dimension, for both the possible responses.
%       - classProb => a 2x1 vector containing the probability to belong in
%                   one class for a random data item.
    
    [n, d] = size(Xtr); 
    classProb = zeros(2, 1);
    mean = zeros(d, 2);
    variance = zeros(d, 2);
    
    for i = 1:d % For each dimension
        for j = 1:2 % For each class
            % Count the elements belonging to that class and
            % ompute the probability of belonging to that class
            [count, ~] = size(Ytr(Ytr == j));
            classProb(j) = count/n;
            
            % Compute the mean and the variance
            mean(i, j) = sum(Xtr(Ytr == j, i))/count;
            variance(i, j) = var(Xtr(Ytr == j, i));
        end
    end
end

