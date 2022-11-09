%A meanfrequency plot YANAN ZHAO 05242022. Please refer to original publication for source data
r=xlsread('meanfrequ.xlsx','r');
s=xlsread('meanfrequ.xlsx','s');
w=xlsread('meanfrequ.xlsx','w');

ms=mean(s);
mr=mean(r);
mw=mean(w);
meanall=[ms,mr,mw];

a=w-s;
b=w+s;
c=r-s;
d=r+s;
x=a./b;
y=c./d;

z=[x,y];
Z=normalize(z,'zscore');
% X=normalize(x,'zscore');
% Y=normalize(y,'zscore');
for i=1:12
    X(1,i)=Z(1,i);
    Y(1,i)=Z(1,i+12);
end
% Z(1,:)=X;
% Z(2,:)=Y;


dot(:,1)=s';
dot(:,2)=r';
dot(:,3)=w';

A(1,:)=dot(1,:);
A(2,:)=dot(8,:);
A(3,:)=dot(9,:);
A(4,:)=dot(10,:);
% A(5,:)=dot(11,:);
A(5,:)=dot(12,:);


X1(1,1)=X(1,1);
X1(1,2)=X(1,8);
X1(1,3)=X(1,9);
X1(1,4)=X(1,10);
% X1(1,5)=X(1,11);
X1(1,5)=X(1,12);

Y1(1,1)=Y(1,1);
Y1(1,2)=Y(1,8);
Y1(1,3)=Y(1,9);
Y1(1,4)=Y(1,10);
% Y1(1,5)=Y(1,11);
Y1(1,5)=Y(1,12);

NREMon=mean(A);

B(1,:)=dot(2,:);
B(2,:)=dot(3,:);
B(3,:)=dot(4,:);
B(4,:)=dot(5,:);
B(5,:)=dot(6,:);
B(6,:)=dot(7,:);

X2(1,1)=X(1,2);
X2(1,2)=X(1,3);
X2(1,3)=X(1,4);
X2(1,4)=X(1,5);
X2(1,5)=X(1,6);
X2(1,6)=X(1,7);

Y2(1,1)=Y(1,2);
Y2(1,2)=Y(1,3);
Y2(1,3)=Y(1,4);
Y2(1,4)=Y(1,5);
Y2(1,5)=Y(1,6);
Y2(1,6)=Y(1,7);

NREMoff=mean(B);

subplot(3,2,1)
scatter(X,Y);
grid on
xlim([-2 2])
ylim([-2 2])
axis square

subplot(3,2,2)
bar(meanall)
hold on
plot(dot')
axis square

subplot(3,2,3)
scatter(X1,Y1);
grid on
xlim([-2 2])
ylim([-2 2])
axis square

subplot(3,2,4)
bar(NREMon)
hold on
plot(A')
axis square

subplot(3,2,5)
scatter(X2,Y2);
grid on
xlim([-2 2])
ylim([-2 2])
axis square

subplot(3,2,6)
bar(NREMoff)
hold on
plot(B')
axis square

% E=[X1,Y1];
% F=[X2,Y2];
[p1,h1,stats1] = ranksum(X1,X2); 
[p2,h2,stats2] = ranksum(X1,Y1); 
[p3,h3,stats3] = ranksum(X1,Y2); 
[p4,h4,stats4] = ranksum(Y1,X2); 
[p5,h5,stats5] = ranksum(X2,Y2); 
[p6,h6,stats6] = ranksum(Y1,Y2); 
% [c,m,h,nms] = multcompare(stats1);
% plot(z)
% hold on
% plot(Z)