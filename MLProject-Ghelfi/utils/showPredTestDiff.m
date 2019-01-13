function [diff] = showPredTestDiff(Xts, Yts, Ypred, name)
%SHOWPREDTESTDIFF Summary of this function goes here
%   Detailed explanation goes here
    diff = difference(Xts, Yts, Ypred);
    figure;
    view(3);
    grid on;
    hold all;
    scatter3(Xts(:, 1), Xts(:, 2), Xts(:,3), 25, Ypred);
    scatter3(diff(:, 1), diff(:, 2), diff(:,3), 50, 'og');
    xlabel("age");
    ylabel("year");
    zlabel("lymph nodes");
    title(["Original VS Predicted labels with " name])
end

