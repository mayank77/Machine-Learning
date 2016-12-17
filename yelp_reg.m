%Loading Data
data_training = csvread ('regression_dataset_training.csv' ,1) ;
data_testing = csvread ('regression_dataset_testing.csv' ,1) ;
data_answer = csvread ('regression_dataset_testing_solution.csv' ,1) ;

fullX = data_training(:,2:51);
fullY = data_training(:,52);
testX = data_testing(:,2:51);

testY=yelp_neural(testX);
sum_mse = 0;
for i=1 : length(testY)
    sum_mse = sum_mse + (testY(i,1) - data_answer(i,2))*(testY(i,1) - data_answer(i,2));
end
mse = sum_mse/length(testY);
vpa(mse)
%csvwrite('res_mayank7.csv',result)
