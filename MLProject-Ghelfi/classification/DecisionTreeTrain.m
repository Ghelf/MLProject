function [boundaries, dimensions, life] = DecisionTreeTrain(Xtr, Ytr, maxdepth)
%DECISIONTREE Summary of this function goes here
%   Detailed explanation goes here
    [n, d] = size(Xtr);
    boundaries = [];
    dimensions = [];
    life = [];
    if maxdepth == 0
        boundaries = vertcat(boundaries, 0);
        dimensions = vertcat(dimensions, 0);
        life = vertcat(life, 0);
        return;    
    end
     
     if size(Ytr) == 1
        boundaries = vertcat(boundaries, 0);
        dimensions = vertcat(dimensions, 0);
        life = vertcat(life, 0);
        return;
     end
     
     if isempty(Ytr)
        boundaries = vertcat(boundaries, 0);
        dimensions = vertcat(dimensions, 0);
        life = vertcat(life, 0);
        return;
     end
     
    imp = impurity(Xtr, Ytr);
    [gain, boundary, dim] = findBestSplit(Xtr, Ytr, imp);
    if gain == 0
        boundaries = vertcat(boundaries, 0);
        dimensions = vertcat(dimensions, 0);
        life = vertcat(life, 0);
        return;
    end
    [Xleft, Yleft, Xright, Yright, vim] = splitSet(Xtr, Ytr, boundary, dim);
    

    boundaries = vertcat(boundaries, boundary);
    dimensions = vertcat(dimensions, dim);
    life = vertcat(life, vim);

    [bleft, dleft, vleft] = DecisionTreeTrain(Xleft, Yleft, maxdepth-1);
    [bright, dright, vright] = DecisionTreeTrain(Xright, Yright, maxdepth-1);

    boundaries = horzcat(boundaries, bleft);
    boundaries = horzcat(boundaries, bright);
    dimensions = horzcat(dimensions, dleft);
    dimensions = horzcat(dimensions, dright);
    life = horzcat(life, vleft);
    life = horzcat(life, vright);

    
    
end

