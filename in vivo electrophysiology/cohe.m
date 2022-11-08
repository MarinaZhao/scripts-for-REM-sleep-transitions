coh=xlsread('coherence.xlsx','realdata');
unitn=12;
frequency=coh(:,1);
coh(:,1)=[];
cohdata=coh';

cohmean=mean(cohdata);
cohsem=std(cohdata)/sqrt(unitn);
CI95 = tinv([0.025 0.975], unitn-1);
yCI95 = bsxfun(@times, cohsem, CI95(:));

shadearea=yCI95+cohmean;
up=shadearea(1,:);
down=shadearea(2,:);
l=length(frequency);
xl=[frequency(1,1):0.195313:frequency(l,1)+0.195313];

subplot(1,2,1)
cohdata(:,77:256)=[];
imagesc(cohdata);
colorbar;
colormap(parula);

subplot(1,2,2)
fill([xl fliplr(xl)], [up fliplr(down)],'blue','FaceAlpha',.1)
hold on
% line(xl,up);
% hold on 
% line(xl,down); % Plot 95% Confidence Intervals Of All values
% hold on
line(xl,cohmean,'color','blue','linewidth',2);
xlim ([0 15]);
ylim ([0 0.25]);
hold off 