%A raster plot CHAPTER 13 NEURAL DATA ANALYSIS:ENCODING 641-4.08
a=xlsread('forshow_642-4.0-006.xlsx','r_spike2');
j=length(a);
subplot(1,2,1)
for i=1:j
line([a(i,:) a(i,:)], [0,1],'color','black')
end

% ylim([0 1]);
% yticks([0:1]);
bin=0.5;
min=a(1,1);
max=a(j,1);
edge=[min:bin:max+bin];
[N,edges] = histcounts(a,edge);
subplot(1,2,2)
bar(N)



