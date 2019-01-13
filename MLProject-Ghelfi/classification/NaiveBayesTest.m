function [Ypred] = NaiveBayesTest(Xts, variance, mean, classprob)
%This Naive Bayes test function predicts the labels of a test set according
%to the mean and the variance for the training set.
%   This function is based on the Bayesian theorem according to which we
%   can predict a posteriori if a x belongs to a y class having the
%   probability of belonging to that class and the conditional probabilities
%   for each attribute, given that class. All the attributes have to be 
%   considered as they were independent.
%   Input parameters:
%       - Xts => the test set;
%       - mean => a dx2 matrix containing the mean for each dimension, 
%                 for both the possible responses (positive and negative);
%       - variance => a dx2 matrix containing the variance for each 
%                   dimension, for both the possible responses.
%       - classProb => a 2x1 vector containing the probability to belong in
%                   one class for a random data item.
%   Output:
%       - Ypred => a vector containing the predicted labels;

    [n, ~] = size(Xts);
    Ypred = zeros(n, 1);
    % In probs there are the probabilities of belonging to the first and to
    % the second class; it will be useful for the final comparison.
    probs = zeros(2, 1); 
    
    for i = 1:n % For each data item in Xts
        for j = 1:2 % For each possibile class (binary, so 1 or 2)
            % Compute the probability of belonging to that class
            probs(j, :) = classprob(j, :) * prodGaussCond(Xts(i, :), variance(:,j), mean(:,j));
        end
        % And then assign the classes following the higher probability.
        if probs(1, :) >= probs(2, :)
            Ypred(i, :) = 1;
        else
            Ypred(i, :) = 2;
        end
           
    end
end

