%Adding the directories involved in the project
addpath("utils");
addpath("classification");

%Upload the data
data = csvread("Haberman.csv");
X = data(:, 1:3);
Y = data(:, 4);


percs = zeros(2, 1);
numIter = 20;
percTs = 0.9;
decTreeErr = zeros(numIter, 1);
naiveBayesErr = zeros(numIter, 1);
for i = 1:numIter
    %Splitting the data
    [Xtr,Ytr,Xts,Yts] = testSplit(X, Y, percTs); 
    [n, ~] = size(Xts);

    [bounds, dims, life] = DecisionTreeTrain(Xtr, Ytr, 2);
    [Ypred] = DecisionTreeTest(Xts, bounds, dims, life, 1);
    [d, ~] = size(difference(Xts, Yts, Ypred));
    decTreeErr(i, :) = d*100/n;
    
    [mean, variance, classprob] = NaiveBayesTrain(Xtr, Ytr);
    [Ypred] = NaiveBayesTest(Xts, mean, variance, classprob);
    [d, ~] = size(difference(Xts, Yts, Ypred));
    naiveBayesErr(i, :) = d*100/n;
end
    [e1, ~] = size(decTreeErr);
    [e2, ~] = size(naiveBayesErr);
    percs(1, :) = sum(decTreeErr)/e1;
    percs(2, :) = sum(naiveBayesErr)/e2;
    percs