% Waveform plot NEURAL DATA YANAN ZHAO 01032021. Please refer to
% original publication for source data.
spon=xlsread('waveform.xlsx','waveform_black');
for j=1:500;
    spontan=[];
    for i=1:160
     spontan=[spontan;spon(j,i)];
    end
hold on  
plot(spontan,'color','black');

end

las=xlsread('waveform.xlsx','waveform_blue');
for a=1:50;
    laser=[];
    for i=1:160
     laser=[laser;las(a,i)];
    end
plot(laser,'color','blue');
end
hold off