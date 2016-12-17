%DATASET : The data is exchange rates of euro versus dollar from 1999 to 2013 - 2 Variables and 3766 Data Items

%Loading Data
load C:\Users\Mayank\Desktop\ex2_traindata.txt;
load C:\Users\Mayank\Desktop\ex2_testdata.txt;
ex2_traindata = sortrows(ex2_traindata);

%Setting Up Data Matrices
ex2_traindata_x=[];ex2_traindata_y=[];ex2_validdata_x=[];ex2_validdata_y=[];
ex2_testdata_x=ex2_testdata(:,1);
ex2_testdata_y=ex2_testdata(:,2);

%Cross Validation Partition
k=10;
samplesize = size( ex2_traindata , 1);
c = cvpartition(samplesize,  'kfold' , k);

%Initialization of Variables
degrees=15;
total = zeros(degrees,1);
p{1} = zeros(2,1);
err = zeros(degrees,1);

%Obtaining Test Sets
for i=1 : k
   trainInd = find(training(c,i) );
   valInd  = find(test(c,i)       );

%Splitting Training Set
    for x = trainInd
    ex2_traindata_x = [ex2_traindata_x ; ex2_traindata(x,1)];
    ex2_traindata_y = [ex2_traindata_y ; ex2_traindata(x,2)];
    end

%Splitting Validation Set
    for y = valInd
    ex2_validdata_x = [ex2_validdata_x ; ex2_traindata(y,1)];
    ex2_validdata_y = [ex2_validdata_y ; ex2_traindata(y,2)];
    end

 %Fitting, Error w.r.t Validation and Test Data Success
    for counter=1 : degrees  
    p{counter}=polyfit(ex2_traindata_x,ex2_traindata_y,counter);
    err(counter,1) = sum((ex2_validdata_y-polyval(p{counter},ex2_validdata_x)).^2)/size(ex2_validdata_x,1);
    total(counter,1) = total(counter,1)+sum((ex2_testdata_y-polyval(p{counter},ex2_testdata_x)).^2)/size(ex2_testdata_x,1);
   end   
end

%Averaging Results
for j=1 : degrees
   total(j,1) = total(j,1)/degrees;
end
%Maintaining Precision
vpa(total)
