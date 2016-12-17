%Loading Data
data_training = csvread ('regression_dataset_training.csv' ,1) ;
data_testing = csvread ('regression_dataset_testing.csv' ,1) ;
data_answer = csvread ('regression_dataset_testing_solution.csv' ,1) ;
fullX = data_training(:,2:51);
fullY = data_training(:,52);

testX = data_testing(:,2:51);

p{1}=fitlm(fullX,fullY);
testY = ( predict(p{1},testX) );
testY_round = round( predict(p{1},testX) );
testY_pseudo = testY;

mse_pseudo_val = [];
t = [];
for threshold = [0:0.01:0.5]
    for i=1 : length(testY)
        if( abs(testY(i,1) - testY_round(i,1) )<=threshold )
            testY_pseudo(i,1) = testY_round(i,1);
        end
    end
    sum_mse = 0;
    for i=1 : length(testY)
        sum_mse = sum_mse + (testY_pseudo(i,1) - data_answer(i,2))*(testY_pseudo(i,1) - data_answer(i,2));
    end
    mse_pseudo = sum_mse / length(testY_pseudo);
    mse_pseudo_val = [mse_pseudo_val mse_pseudo];
    t = [t threshold];
end
sum_mse = 0
for i=1 : length(testY)
        sum_mse = sum_mse + (testY(i,1) - data_answer(i,2))*(testY(i,1) - data_answer(i,2));
end
mse = sum_mse/length(testY)
sum_mse = 0
for i=1 : length(testY)
        sum_mse = sum_mse + (testY_round(i,1) - data_answer(i,2))*(testY_round(i,1) - data_answer(i,2));
end

mse_round = sum_mse/length(testY)
mse_pseudo = mean(mse_pseudo_val)
