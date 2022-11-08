clear
clc
% w=zeros(1,75);
% r=zeros(1,75);
% s=zeros(1,75);
[Filename, Files_path] = uigetfile('*.txt', 'Open Transition Data');

if Filename == 0
    return;
end

DaFile_list = dir(strcat(Files_path,'*.txt'));
Files_NO = length(DaFile_list);
wake=[];
rem=[];
nrem=[];
for File= 1:Files_NO
    Files_name = DaFile_list(File).name;% �ļ���
    txtfile=strcat(Files_path,Files_name);
    try
        [lineNO, Epoch_NO, Trans_Time, Epidose,Count,Duration,another] =  textread(txtfile,'%d %d %s %s %d %d %s','delimiter','\t','headerlines',29);
    catch
        [lineNO, Epoch_NO, Trans_Time, Epidose,Count,Duration,another] =  textread(txtfile,'%d %d %s %s %d %d %s','delimiter','\t','headerlines',30);
    end
    FirstLine(File)=lineNO(1);
    Epsiodetext{File}=Epidose;
    Counttext{File}=Count;
    Epsidose_max(File)=length(Epidose);
    Sum_count(File)=sum(Count);
    %Trans_Timenum=datenum(Trans_Time);
    %Trans_timerang(File)=(max(Trans_Timenum)-min(Trans_Timenum))*86400+Duration(end);
    Epoch_duration(File)=sum(Duration)/sum(Count);
    Sum_duration(File)=sum(Duration);
    


CheckRead=any(FirstLine-1);

duration=round(mean(Epoch_duration));
TotalTime=round(mean(Sum_duration));

Episode_NO=max(Epsidose_max);

Epsiodenum=zeros(Episode_NO,File);


    Trialtext=Epsiodetext{File};
    Episode_NO=length(Trialtext);
    for Episode=1:Episode_NO
        W='W';
        R='R';
        S='S';
        if Trialtext{Episode}==W
            Epsiodenum(Episode,1)=1;
        elseif Trialtext{Episode,1}==R
            Epsiodenum(Episode,1)=2;
        elseif Trialtext{Episode,1}==S
            Epsiodenum(Episode,1)=3;
        end
    end

Hypnogram=zeros(max(Sum_count),1);

    Epsiode_num=length(Epsiodetext{File});
    Epsiodecount=Counttext{File};
    i=1;
    for epsiode=1:Epsiode_num
        count=Epsiodecount(epsiode);
        Nexti=i+count-1;
        Hypnogram(i:Nexti,1)=Epsiodenum(epsiode);
        i=i+count;
    end
    

Hypnogram1=Hypnogram';
Hypnogram_S=Hypnogram1;

for i=1:size(Hypnogram1,1)
    for j=1:size(Hypnogram1,2)
        if Hypnogram1(i,j)==1 || Hypnogram1(i,j)==2
           Hypnogram_S(i,j)=0;
        end
    end
end

trials=size(Hypnogram_S,1);
Cumulative_Probability_ori=zeros(size(Hypnogram_S));

for epoch=1:size(Hypnogram_S,2)    
    for trial=1:trials        
        if Hypnogram_S(trial,epoch)==3 && ~any(Cumulative_Probability_ori(trial,:))            
            Cumulative_Probability_ori(trial,epoch:end)=1;            
        end        
    end    
end
Cumulative_Probability=sum(Cumulative_Probability_ori)/trials*100;
% figure
% plot(Cumulative_Probability);
%
% figure
% imagesc(Cumulative_Probability_ori);
Cumulative_Probability_check=any(Cumulative_Probability_ori,2);
heat_check=any(Hypnogram_S-1,2);
Fail_check=[Cumulative_Probability_check heat_check];


Episode_NO=75;
start=106;
start0=105;
endd=start+Episode_NO-1;
% wake=[];
% rem=[];
% nrem=[];
prob=(0:1:75);
pro=prob';
i=1;
j=1;
l=1;
Wake=zeros(Episode_NO,1);
REM=zeros(Episode_NO,1);
NREM=zeros(Episode_NO,1);
for Episode=start:endd
    Episode105=Episode-start0;
        if Hypnogram(Episode)==1
            Wake(Episode105,1)=Wake(Episode105,1)+1;
        elseif Hypnogram(Episode)==2
            REM(Episode105,1)=REM(Episode105,1)+1;
        elseif Hypnogram(Episode)==3
            NREM(Episode105,1)=NREM(Episode105,1)+1;
        end
       
end

Wake=Wake';
REM=REM';
NREM=NREM';

wake=[wake;Wake];
rem=[rem;REM];
nrem=[nrem;NREM];

end

% W(1,:)=[];
% R(1,:)=[];
% N(1,:)=[];
WAKEs=sum(wake);
REMs=sum(rem);
NREMs=sum(nrem);
Wake_control=(WAKEs/Files_NO);
REM_control=(REMs/Files_NO);
NREM_control=(NREMs/Files_NO);

% Wake=(Wake/Trails_NO);
% NREM=(NREM/Trails_NO);
% REM=(REM/Trails_NO);
% x=(1:length(Wake))';

Wake_CI95P=(Wake_control+sqrt(Wake_control.*(1-Wake_control)/Files_NO));
Wake_CI95N=(Wake_control-sqrt(Wake_control.*(1-Wake_control)/Files_NO));
SE_W_control=sqrt(Wake_control.*(1-Wake_control)/Files_NO);

REM_CI95P=(REM_control+sqrt(REM_control.*(1-REM_control)/Files_NO));
REM_CI95N=(REM_control-sqrt(REM_control.*(1-REM_control)/Files_NO));
SE_R_control=sqrt(REM_control.*(1-REM_control)/Files_NO);

NREM_CI95P=(NREM_control+sqrt(NREM_control.*(1-NREM_control)/Files_NO));
NREM_CI95N=(NREM_control-sqrt(NREM_control.*(1-NREM_control)/Files_NO));
SE_N_control=sqrt(NREM_control.*(1-NREM_control)/Files_NO);


% w0=zeros(1,75);
% r0=zeros(1,75);
% s0=zeros(1,75);

% Wake_control=Wake_control*100;
% REM_control=REM_control*100;
% NREM_control=NREM_control*100;


[Filename, Files_path] = uigetfile('*.txt', 'Open Transition Data');

if Filename == 0
    return;
end

DaFile_list = dir(strcat(Files_path,'*.txt'));
Files_NO = length(DaFile_list);
W0=[];
R0=[];
N0=[];
for File= 1:Files_NO
    Files_name = DaFile_list(File).name;% �ļ���
    txtfile=strcat(Files_path,Files_name);
    try
        [lineNO, Epoch_NO, Trans_Time, Epidose,Count,Duration,another] =  textread(txtfile,'%d %d %s %s %d %d %s','delimiter','\t','headerlines',29);
    catch
        [lineNO, Epoch_NO, Trans_Time, Epidose,Count,Duration,another] =  textread(txtfile,'%d %d %s %s %d %d %s','delimiter','\t','headerlines',30);
    end
    FirstLine(File)=lineNO(1);
    Epsiodetext{File}=Epidose;
    Counttext{File}=Count;
    Epsidose_max(File)=length(Epidose);
    Sum_count(File)=sum(Count);
    %Trans_Timenum=datenum(Trans_Time);
    %Trans_timerang(File)=(max(Trans_Timenum)-min(Trans_Timenum))*86400+Duration(end);
    Epoch_duration(File)=sum(Duration)/sum(Count);
    Sum_duration(File)=sum(Duration);
    


CheckRead=any(FirstLine-1);

duration=round(mean(Epoch_duration));
TotalTime=round(mean(Sum_duration));

Episode_NO=max(Epsidose_max);

Epsiodenum=zeros(Episode_NO,File);


    Trialtext=Epsiodetext{File};
    Episode_NO=length(Trialtext);
    for Episode=1:Episode_NO
        W='W';
        R='R';
        S='S';
        if Trialtext{Episode}==W
            Epsiodenum(Episode,1)=1;
        elseif Trialtext{Episode,1}==R
            Epsiodenum(Episode,1)=2;
        elseif Trialtext{Episode,1}==S
            Epsiodenum(Episode,1)=3;
        end
    end

Hypnogram=zeros(max(Sum_count),1);

    Epsiode_num=length(Epsiodetext{File});
    Epsiodecount=Counttext{File};
    i=1;
    for epsiode=1:Epsiode_num
        count=Epsiodecount(epsiode);
        Nexti=i+count-1;
        Hypnogram(i:Nexti,1)=Epsiodenum(epsiode);
        i=i+count;
    end
    

Hypnogram1=Hypnogram';
Hypnogram_S=Hypnogram1;

for i=1:size(Hypnogram1,1)
    for j=1:size(Hypnogram1,2)
        if Hypnogram1(i,j)==1 || Hypnogram1(i,j)==2
           Hypnogram_S(i,j)=0;
        end
    end
end

trials=size(Hypnogram_S,1);
Cumulative_Probability_ori=zeros(size(Hypnogram_S));

for epoch=1:size(Hypnogram_S,2)    
    for trial=1:trials        
        if Hypnogram_S(trial,epoch)==3 && ~any(Cumulative_Probability_ori(trial,:))            
            Cumulative_Probability_ori(trial,epoch:end)=1;            
        end        
    end    
end
Cumulative_Probability=sum(Cumulative_Probability_ori)/trials*100;
% figure
% plot(Cumulative_Probability);
%
% figure
% imagesc(Cumulative_Probability_ori);
Cumulative_Probability_check=any(Cumulative_Probability_ori,2);
heat_check=any(Hypnogram_S-1,2);
Fail_check=[Cumulative_Probability_check heat_check];


Episode_NO=75;
start=106;
start0=105;
endd=start+Episode_NO-1;
% W0=[];
% R0=[];
% N0=[];
prob=(0:1:75);
pro=prob';
i=1;
j=1;
l=1;
Wake0=zeros(Episode_NO,1);
REM0=zeros(Episode_NO,1);
NREM0=zeros(Episode_NO,1);
for Episode=start:endd
    Episode105=Episode-start0;
        if Hypnogram(Episode)==1
            Wake0(Episode105,1)=Wake0(Episode105,1)+1;
        elseif Hypnogram(Episode)==2
            REM0(Episode105,1)=REM0(Episode105,1)+1;
        elseif Hypnogram(Episode)==3
            NREM0(Episode105,1)=NREM0(Episode105,1)+1;
        end
       
end

Wake0=Wake0';
REM0=REM0';
NREM0=NREM0';

W0=[W0;Wake0];
R0=[R0;REM0];
N0=[N0;NREM0];

   
end

% W0(1,:)=[];
% R0(1,:)=[];
% N0(1,:)=[];
WAKEs0=sum(W0);
REMs0=sum(R0);
NREMs0=sum(N0);
Wake_laser=WAKEs0/Files_NO;
REM_laser=REMs0/Files_NO;
NREM_laser=NREMs0/Files_NO;


Wake0_CI95P=(Wake_laser+sqrt(Wake_laser.*(1-Wake_laser)/Files_NO));
Wake0_CI95N=(Wake_laser-sqrt(Wake_laser.*(1-Wake_laser)/Files_NO));
SE_W_laser=sqrt(Wake_laser.*(1-Wake_laser)/Files_NO);

REM0_CI95P=(REM_laser+sqrt(REM_laser.*(1-REM_laser)/Files_NO));
REM0_CI95N=(REM_laser-sqrt(REM_laser.*(1-REM_laser)/Files_NO));
SE_R_laser=sqrt(REM_laser.*(1-REM_laser)/Files_NO);

NREM0_CI95P=(NREM_laser+sqrt(NREM_laser.*(1-NREM_laser)/Files_NO));
NREM0_CI95N=(NREM_laser-sqrt(NREM_laser.*(1-NREM_laser)/Files_NO));
SE_N_laser=sqrt(NREM_laser.*(1-NREM_laser)/Files_NO);
% w0(1,:)=[];
% r0(1,:)=[];
% s0(1,:)=[];

% Wake_laser=Wake_laser*100;
% NREM_laser=NREM_laser*100;
% REM_laser=REM_laser*100;

%     Wcolor=[0 1 0];
% 
%     Rcolor=[1 0 0];
% 
%     Ncolor=[0 0 1];
    
x=(1:length(REM_laser));

subplot(3,1,1)
fill([x fliplr(x)], [REM_CI95P fliplr(REM_CI95N)], [0,0,0],'FaceAlpha',0.3,'EdgeAlpha',0.3);
% patch([x;flipud(x)],[REM_CI95P;flipud(REM_CI95N)],Rcolor,'FaceColor','k','EdgeA',0,'FaceAlpha',facealpha);
line(x,REM_control,'color','k','linewidth',2);
hold on
% patch([x;flipud(x)],[REM0_CI95P;flipud(REM0_CI95N)],Rcolor,'FaceColor','k','EdgeA',0,'FaceAlpha',facealpha);
fill([x fliplr(x)], [REM0_CI95P fliplr(REM0_CI95N)], [1.0,0,1.0],'FaceAlpha',0.3,'EdgeAlpha',0.3);
line(x,REM_laser,'color','m','linewidth',2);
xlim([0 75]);

subplot(3,1,2)
fill([x fliplr(x)], [Wake_CI95P fliplr(Wake_CI95N)], [0,0,0],'FaceAlpha',0.3,'EdgeAlpha',0.3);
line(x,Wake_control,'color','k','linewidth',2);
hold on
fill([x fliplr(x)], [Wake0_CI95P fliplr(Wake0_CI95N)], [0,1.0,0],'FaceAlpha',0.3,'EdgeAlpha',0.3);
line(x,Wake_laser,'color','green','linewidth',2);
xlim([0 75]);

subplot(3,1,3)
fill([x fliplr(x)], [NREM_CI95P fliplr(NREM_CI95N)], [0,0,0],'FaceAlpha',0.3,'EdgeAlpha',0.3);
line(x,NREM_control,'color','k','linewidth',2);
hold on
fill([x fliplr(x)], [NREM0_CI95P fliplr(NREM0_CI95N)], [0,0,1.0],'FaceAlpha',0.3,'EdgeAlpha',0.3);
line(x,NREM_laser,'color','b','linewidth',2);
xlim([0 75]);

% prompt = 'input address\n';
% filename = input(prompt,'s');
% xlswrite(filename,Wake_control,'Wake_control');
% % xlswrite(filename,Wake_laser,'Wake_laser');
% % xlswrite(filename,REM_control,'REM_control');
% % xlswrite(filename,REM_laser,'REM_laser');
% % xlswrite(filename,NREM_control,'NREM_control');
% % xlswrite(filename,NREM_laser,'NREM_laser');
% % xlswrite(filename,SE_W_control,'SE_W_control');
% % xlswrite(filename,SE_W_laser,'SE_W_laser');
% % xlswrite(filename,SE_R_control,'SE_R_control');
% % xlswrite(filename,SE_R_laser,'SE_R_laser');
% % xlswrite(filename,SE_N_control,'SE_N_control');
% % xlswrite(filename,SE_N_laser,'SE_N_laser');
Data=[];
Data=[Data;REM_control];
Data=[Data;SE_R_control];
Data=[Data;REM_laser];
Data=[Data;SE_R_laser];

Data=[Data;NREM_control];
Data=[Data;SE_N_control];
Data=[Data;NREM_laser];
Data=[Data;SE_N_laser];

Data=[Data;Wake_control];
Data=[Data;SE_W_control];
Data=[Data;Wake_laser];
Data=[Data;SE_W_laser];

% prompt = 'input address\n';
% filename = input(prompt,'s');
% 
% xlswrite(filename,Data);
