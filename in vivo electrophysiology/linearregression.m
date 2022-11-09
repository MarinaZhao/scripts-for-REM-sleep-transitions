% Linearregression NEURAL DATA YANAN ZHAO 02032021. Please refer to
% original publication for source data
x=1:30;
count=xlsread('r-30s-231.xlsx','Sheet1');
y=mean(count);
[p,S] = polyfit(x,y,1);
[y_fit,delta] = polyval(p,x,S);
subplot(2,1,1)
plot(x,y,'bo')
hold on
plot(x,y_fit,'r-')
plot(x,y_fit+2*delta,'m--',x,y_fit-2*delta,'m--')
title('Linear Fit of Data with 95% Prediction Interval')
legend('Data','Linear Fit','95% Prediction Interval')
a=x';
b=y';
mdl= fitlm(a,b)
subplot(2,1,2)
plot(mdl);
xlim([0 30]);
ylim([15 30]);

