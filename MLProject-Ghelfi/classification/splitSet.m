function [Xleft, Yleft, Xright, Yright, vim] = splitSet(Xtr, Ytr, boundary, dim)
%SPLITSET Summary of this function goes here
%   Detailed explanation goes here
    if size(Ytr) == 1
        return;
    end
    Xmaj = Xtr(Xtr(:, dim) >= boundary, :);
    Ymaj = Ytr(Xtr(:, dim) >= boundary, :);
    Xmin = Xtr(Xtr(:, dim) < boundary, :);
    Ymin = Ytr(Xtr(:, dim) < boundary, :);
    
    Xright = Xmaj;
    Yright = Ymaj;
    Xleft = Xmin;
    Yleft = Ymin;
    
    [one, ~] = size(Xmaj(Ymaj==1,:));
    [two, ~] = size(Xmaj(Ymaj==2,:));

    if one > two
       vim = 1;
    else
        vim = 2;
    end
end

