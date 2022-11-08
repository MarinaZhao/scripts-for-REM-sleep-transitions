% adv=xlsread('96-3.8375-adv.xlsx','r');

% advselect=advunit2;

% 
% for e=1:136
%     advselect1{1,e}=advselect{1,e+30};
% end
%     
[a,b]=size(advselect);
% advselect={};
% for x=1:b
%     columnselect=adv(:,x);
%     realcolumnselect=rmmissing(colimresizeumnselect);
%     advselect=[advselect,realcolumnselect];
% end

bin=0.01;

m=50; % xmax=m*bin

j=1; % j= unit number

frequency=[];
autocorr={};
values=[];
 

for w=1:b
trial=advselect{:,w};

n=length(trial);
    realmin=trial(1,1);
    realmax=trial(n,1);
    edge=[realmin:bin:realmax];
    

[N,edges] = histcounts(trial,edge);
freq=(N/bin);
mean1=mean(freq');
frequency=[frequency,mean1];

[autoc,lag]=xcorr(freq,"coeff");
autocorr=[autocorr;autoc];

% delay=lag(length(freq):length(freq)+m);
length(freq);

value=autoc(length(freq):length(freq)+m);
norvalue=normalize(value,'range'); % normalize value to [0 1]
values=[values;norvalue];

% subplot(2,2,1)
% plot(freq);
% subplot(2,2,2)
% stem(lag,autoc);
% subplot(2,2,3)
% stem(delay,value);
trial=[];
% freq=[];
end

% x=delay;
% y=1:b;
% fre=mean(frequency');

[p1,p]=size(frequency);
j1=p/j;
realf=reshape(frequency,[j,j1]);
realfre=realf';
Rfre=mean(realfre);
% subplot(1,2,1)
% bar(Rfre);
% subplot(2,2,2)
% stem(lag,autocorr);
values(:,1)=[];

valuesmean=mean(values);
valuesem=std(values)/sqrt(m);
CI95 = tinv([0.025 0.975], m-1);
yCI95 = bsxfun(@times, valuesem, CI95(:));
shadearea=yCI95+valuesmean;
up=shadearea(1,:);
down=shadearea(2,:);
xl=[1:1:m];

subplot(1,2,1)
fill([xl fliplr(xl)], [up fliplr(down)], [0.8,1.0,1.0])
hold on
% line(xl,up);
% hold on 
% line(xl,down); % Plot 95% Confidence Intervals Of All values
% hold on
line(xl,valuesmean,'color','blue','linewidth',2);
ylim ([0 0.25]);
hold off 

subplot(1,2,2)
imagesc(values);
colorbar;
colormap(parula);