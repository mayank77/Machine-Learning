%Find Important Features for Classification

%CLASSIFICATION ERROR ON TRAINING SET = 0.1375
%CLASSIFICATION ERROR ON TEST SET = 0.2674
% w = 34.2087 //ML Estimate
% w0 = 0.9182 //ML Estimate
%14th FEATURE IS THE MOST IMPORTANT (and gives lest error) -- maximum association


load C:\Users\Mayank\Documents\MATLAB\spect_training.txt;
load C:\Users\Mayank\Documents\MATLAB\spect_test.txt;
ex2_traindata = spect_training;
ex2_testdata = spect_test;
total=0;
class1 = spect_training((spect_training(:,9)==0),:);
class2 = spect_training((spect_training(:,9)==1),:);
p1 = sum(spect_training(:,1) == 0 ) / ((sum(spect_training(:,1) == 1)+(sum(spect_training(:,1) == 0))));
p2 = sum(spect_training(:,1) == 1 ) / ((sum(spect_training(:,1) == 1)+(sum(spect_training(:,1) == 0))));

spect_training_x = spect_training(:,1);
spect_training_y = spect_training(:,2:23);
spect_test_x = spect_test(:,1);
spect_test_y = spect_test(:,2:23);
Mdl = fitcecoc(spect_training_y , spect_training_x);
error_test = sum((spect_test_x-predict(Mdl,spect_test_y)).^2)/size(spect_test_y,1);
error_training = sum((spect_training_x-predict(Mdl,spect_training_y)).^2)/size(spect_training_y,1);
min_error = 999;
for i=2 : 23
   spect_training_y = spect_training(:,i);
   spect_test_y = spect_test(:,i); 
   Mdl = fitcecoc(spect_training_y , spect_training_x);
   if ( sum((spect_test_x-predict(Mdl,spect_test_y)).^2)/size(spect_test_y,1) ) < min_error;
       min_error = sum((spect_test_x-predict(Mdl,spect_test_y)).^2)/size(spect_test_y,1);
       index = i;
   end
end

pr = @(a,b) sum(spect_training(:,a) == b ) / ((sum(spect_training(:,a) == b)+(sum(spect_training(:,a) == (1-b)))));
p = @(a,b,c) sum(spect_training(:,a) == spect_training(:,b) == c ) / ((sum(spect_training(:,a) == c)+(sum(spect_training(:,a) == (1-c)))));

w1 = log(p(1,2,1)) - log(1-p(1,2,1)) - log(pr(2,1)) + log(1 - pr(2,1));
w00 = 0;
w01 = 0;
for i=2 : 23
    w00 = w00 + log(1-p(1,i,1)) - log(1 - pr(1,1));   
end
for i=3 : 23
w01 = w01 +  log(1-p(2,i,1)) + log(pr(1,1));
end
w = w00 - w01;
