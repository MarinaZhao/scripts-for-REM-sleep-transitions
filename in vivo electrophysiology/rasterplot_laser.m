%A raster plot NEURAL DATA YANAN ZHAO 02082022. Please refer to original publication for source data
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
