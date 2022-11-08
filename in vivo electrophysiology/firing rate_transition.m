%A peri-stimulus time histogram CHAPTER 13 NEURAL DATA ANALYSIS:ENCODING
a=xlsread('r2w-96.xlsx');
N=96;
for i=1:N
spike(i).times=a(:,i);
end
psth=zeros(1,120);
edges=[-60:1:60];
count=zeros(1,120);
for j=1:N,i=1:N;
count=cat(1,count,histcounts(spike(j).times,edges));
end
count(1,:)=[];
count(:,81:120)=[];
count(:,1:40)=[];
countmean=mean(count);
countsem=std(count)/sqrt(N);
CI95 = tinv([0.025 0.975], N-1);
yCI95 = bsxfun(@times, countsem, CI95(:));
for j=1:N,i=1:N;
    psth=psth+histcounts(spike(j).times,edges);
end
psth=psth./N;

subplot(2,1,1);
bar([-19:1:20],countmean);
hold on
errorbar([-19:1:20],countmean,countsem,'black');
hold off
xlim([-20 20]);
xlabel('Time (sec)');
ylabel('# of spikes');
legend

%xlim([-0.039 1.039]);
%ylim([0.0 18.0]);
shadearea=yCI95+countmean;
up=shadearea(1,:);
down=shadearea(2,:);
subplot(2,1,2);
xl=[-19:1:20];
fill([xl fliplr(xl)], [up fliplr(down)], [0.8,1.0,1.0]);
line([-19:1:20],countmean,'color','blue','linewidth',2);
xlim([-20 20]);
ylim([10 50]);
xlabel('Time (sec)');
ylabel('# of spikes');
legend                                              % Plot Mean Of All Experiments
hold on
line([-19:1:20], yCI95+countmean,'color','blue','linewidth',1)                                % Plot 95% Confidence Intervals Of All Experiments
hold off
grid
mea=countmean';

%xlim([-0.039 1.039]);
%ylim([0.0 18.0]);

%fit=locfit(psth);
