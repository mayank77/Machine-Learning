%Loading Data
load C:\Users\Mayank\Documents\MATLAB\pima_indians_diabetes.csv;
ex2_traindata = pima_indians_diabetes;
class1 = ex2_traindata((ex2_traindata(:,9)==0),:);
class2 = ex2_traindata((ex2_traindata(:,9)==1),:);
p1 = sum(ex2_traindata(:,9) == 0 ) / ((sum(ex2_traindata(:,9) == 1)+(sum(ex2_traindata(:,9) == 0))));
p2 = sum(ex2_traindata(:,9) == 1 ) / ((sum(ex2_traindata(:,9) == 1)+(sum(ex2_traindata(:,9) == 0))));
u1 = mean(class1(:,3));
u2 = mean(class2(:,3));
v1 = var(class1(:,3));
v2 = var(class2(:,3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Cross Validation Partition
for k=2 : 10
    %k = 2;
    c = cvpartition ( size ( ex2_traindata , 1 ) , 'kfold', k ) ;
    %Initializiation of Variables
    total = 0 ;
    %Obtaining Test Sets
    for i=1 : k
        %Setting Up Data Matrices
        ex2_traindata_x = [ ] ; ex2_traindata_y = [ ] ; ex2_validdata_x = [ ] ; ex2_validdata_y = [ ] ;

        trainInd = find ( training(c,i) ) ;
        valInd = find ( test(c,i) ) ;

        %Splitting Training Set
        for x = trainInd;
            ex2_traindata_x = [ ex2_traindata_x ; ex2_traindata(x,3) ] ;
            ex2_traindata_y = [ ex2_traindata_y ; ex2_traindata(x,9) ] ;
        end

        %Splitting Validation Set
        for y = valInd
            ex2_validdata_x = [ ex2_validdata_x ; ex2_traindata(y , 3 ) ] ;
            ex2_validdata_y = [ ex2_validdata_y ; ex2_traindata(y , 9 ) ] ;
        end

        Mdl = fitcnb(ex2_traindata_x,ex2_traindata_y);
        total = total + sum((ex2_validdata_y-predict(Mdl,ex2_validdata_x)).^2)/size(ex2_validdata_x,1);
    end
    total = total / k;
    vpa(total)
    c.TrainSize(1,1)
end