%Adding the directories involved in the project
addpath("utils");
addpath("utils/utilsRobi");
addpath("clustering");

%Blue points stand for the survivors. 
data = csvread("Haberman.csv");
X = data(:, 1:3);
Y = data(:, 4);
figure;
scatter3(data(:,1),data(:,2),data(:,3),25,data(:,4));
xlabel("age");
ylabel("year");
zlabel("lymph nodes");
title("Plotting survival, age, year and number of lymph nodes");

% Spectral clustering
k = 50;
[vect, idx, median] = spectralClusteringRobi(X, k, 2);
ar = [];
for i = 1:size(vect)
    ar = [ar, i];
end
scatter(ar', vect, 25);
title(['Median value = ' num2str(median)]);
titl = ['Spectral clustering, k = ' num2str(k)];
plot3adHoc(X, idx, [], titl);
showPredTestDiff(X, Y, idx, titl);

[d, ~] = size(difference(X, Y, idx));
[n, ~] = size(Y);
errperc = d*100/n

% Hierarchical clustering
[centers, idx] = hierarchicalClusteringRobi(X, 2);
plot3adHoc(X, idx, centers, "Hierarchical clustering");
showPredTestDiff(X, Y, idx, "Hierarchical clustering");
