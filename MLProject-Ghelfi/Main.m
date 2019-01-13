%Adding the directories involved in the project
addpath("utils");
addpath("clustering");
addpath("classification");

%Loading and visualizing the dataset.
%Blue points stand for the survivors. 
data = csvread("Haberman.csv");
X = data(:, 1:3);
Y = data(:, 4);
figure;
scatter(data(:,1),data(:,2),25,data(:,4))
xlabel("age");
ylabel("year");
title("Plotting survival, age and year");
figure;
scatter3(data(:,1),data(:,2),data(:,3),25,data(:,4));
xlabel("age");
ylabel("year");
zlabel("lymph nodes");
title("Plotting survival, age, year and number of lymph nodes");

% Classification: is this amount of data good to make predictions?
% Dividing the dataset in training set and test set
percTs = 0.7;
[Xtr,Ytr,Xts,Yts] = testSplit(X, Y, percTs);
figure;
scatter3(Xtr(:, 1), Xtr(:, 2), Xtr(:,3), 25, Ytr);
title("Training Set");
figure;
scatter3(Xts(:, 1), Xts(:, 2), Xts(:,3), 25, Yts);
title("Test Set");

% Performing classification: Decision Tree
[bounds, dims, life] = DecisionTreeTrain(Xtr, Ytr, 2);
[Ypred] = DecisionTreeTest(Xts, bounds, dims, life, 1);
figure;
scatter3(Xts(:, 1), Xts(:, 2), Xts(:,3), 25, Ypred);
title("Decision Tree Test");
showPredTestDiff(Xts, Yts, Ypred, "Decision Tree");

% Classification taking into account probability: Naive Bayes
[mean, variance, classprob] = NaiveBayesTrain(Xtr, Ytr);
[Ypred] = NaiveBayesTest(Xts, mean, variance, classprob);
figure;
scatter3(Xts(:, 1), Xts(:, 2), Xts(:,3), 25, Ypred);
title("Naive Bayes Test");
showPredTestDiff(Xts, Yts, Ypred, "Naive Bayes");


% Clustering: is the pattern so recognizable?
% Hard clustering: k-Medoids
[centers] = randomCenters(X, 2);
[idx, centers] = LloydMedoids(X, centers, 20);
plot3adHoc(X, idx, centers, "K-Medoids clustering");
showPredTestDiff(X, Y, idx', "K-Medoids clustering");

% Hard clustering: k-Means
[centers] = randomCenters(X, 2);
[idx, centers] = LloidMeans(X, centers, 20);
plot3adHoc(X, idx, centers, "K-Means clustering");
showPredTestDiff(X, Y, idx', "K-Means clustering");

% Soft clustering: fuzzy clustering (c-means).
[centers] = randomCenters(X, 2);
[idx, c] = fuzzyClustering(X, centers, 15, 20);
plot3adHoc(X, idx, c, "Fuzzy clustering, m = 15");
showPredTestDiff(X, Y, idx', "Fuzzy clustering, m = 15");

[idx, c] = fuzzyClustering(X, centers, 100, 20);
plot3adHoc(X, idx, c, "Fuzzy clustering, m = 100");
showPredTestDiff(X, Y, idx', "Fuzzy clustering, m = 100");

[idx, c] = fuzzyClustering(X, centers, 250, 20);
plot3adHoc(X, idx, c, "Fuzzy clustering, m = 250");
showPredTestDiff(X, Y, idx', "Fuzzy clustering, m = 250");
