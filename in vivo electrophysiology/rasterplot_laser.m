%A raster plot CHAPTER 13 NEURAL DATA ANALYSIS:ENCODING 641-4.08
timestamp=xlsread('9b-laser_rasterplot.xlsx','Sheet1');
for i=1:841
    hold on
timesi=timestamp(:,i);
for j=1:length(timesi)
line([timesi(j) timesi(j)],[0.01*(i-1) 0.01*i],'color','black');
end
end
hold off
xlim([-0.1 0.1]);
xticks([-0.1:0.01:0.1]);
