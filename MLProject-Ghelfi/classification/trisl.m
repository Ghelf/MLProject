[Xtr, Ytr] = MixGauss([[-1;-1],[1;1]],[0.35,0.35],100);
Ytr(Ytr==2)=-1;
[Xts, Yts] = MixGauss([[-1;-1],[1;1]],[0.35,0.35],300);
Yts(Yts==2)=-1;
[Ytrn]=flipLabels(Ytr, 0.3);
[Ytsn]=flipLabels(Yts, 0.3);
figure;
hold on
scatter(Xtr(Ytr==1,1), Xtr(Ytr==1,2), '.r');
scatter(Xtr(Ytr==-1,1), Xtr(Ytr==-1,2), '.b');
title('training set')
hold off
figure;
hold on
scatter(Xts(Yts==1,1), Xts(Yts==1,2), '.r');
scatter(Xts(Yts==-1,1), Xts(Yts==-1,2), '.b');
title('test set')
hold off
figure;
hold on
scatter(Xtr(Ytrn==1,1), Xtr(Ytrn==1,2), '.r');
scatter(Xtr(Ytrn==-1,1), Xtr(Ytrn==-1,2), '.b');
title('training set with noise')
hold off
figure;
hold on
scatter(Xts(Ytsn==1,1), Xts(Ytsn==1,2), '.r');
scatter(Xts(Ytsn==-1,1), Xts(Ytsn==-1,2), '.b');
title('test set with noise')
hold off

w = regularizedLSTrain(Xtr, Ytr, 23479);
Ypred = regularizedLSTest(w, Xts);
sum(Ypred-Ytsn)
figure;
scatter(Xts(:,1),Xts(:,2),25,Ytsn);
hold on
sel = (sign(Ypred) ~= Ytsn);
scatter(Xts(sel,1),Xts(sel,2),200,Ytsn(sel),'x'); 
hold off

separatingFRLS(w, Xts, Ytsn)
% separatingFRLS(w, Xtr, Ytrn)
