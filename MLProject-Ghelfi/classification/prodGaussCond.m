function [prod] = prodGaussCond(Xts, variance, mean)
%This function computes the product of the conditional probabilities
%according to the variance and mean
%   Input parameters:
%       - Xts => the test set;
%       - variance => a dx1 vector containing the variances for each dimension.
%       - mean => a dx1 vector containing the means for each dimension.
%   Output:
%       - prod => The product.
    [~, d] = size(Xts);
    prod = 1;
    for i = 1:d
        var = variance(i,:);
        prod = prod * (1/sqrt(2*pi*var)*exp(-((Xts(:,i)-mean(i,:))/var)^2));
    end
end

