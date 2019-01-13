function [Ypred] = DecisionTreeTest(Xts, boundaries, dimensions, life, first)
%DECISIONTREETEST Summary of this function goes here
%   Detailed explanation goes here
    [n, ~] = size(Xts);
    [~, b] = size(boundaries);

    if b == 0
        if first
            Ypred = ones(n, 1)*randi(2);
            return;
        else
            return;
        end
    end
    
    Ypred = zeros(n, 1);
    
    cur = boundaries(:,1);
    curd = dimensions(:,1);

    if cur == 0
        if first
            Ypred = ones(n, 1)*randi(2);
            return;
        else
            return;
        end
    end
    if first
        left = boundaries(:,1+1);
        right = boundaries(:,1+2);
    else
        left = boundaries(:,1+2);
        right = boundaries(:,1+3);
    end
    if life(:, 1) == 1
        newLife = 2;
    else
        if life(:, 1) ==2
            newLife = 1;
        end
    end
    if (left == 0)
        Ypred(Xts(:, curd) < cur, :) = newLife;
    end
    if (right == 0)
        Ypred(Xts(: , curd) >= cur, :) = life(:, 1);
    end
    if (left ~= 0)
        Yleft = DecisionTreeTest(Xts, boundaries(:, 1+1:end), dimensions(:, 1+1:end), life(:, 1+1:end), 0);
        Ypred(Xts(:, curd) < cur, :) =  Yleft(Xts(:, curd) < cur, :);
    end
    if (right ~= 0)
        Yright = DecisionTreeTest(Xts, boundaries(:, 1:end), dimensions(:, 1:end), life(:, 1:end), 0);
        Ypred(Xts(: , curd) >= cur, :) = Yright(Xts(: , curd) >= cur, :);
    end
end

