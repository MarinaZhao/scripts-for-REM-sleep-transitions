clear
clc
w=zeros(1,15);
r=zeros(1,15);
s=zeros(1,15);
[Filename, Files_path] = uigetfile('*.txt', 'Open Transition Data');

if Filename == 0
    return;
end

DaFile_list = dir(strcat(Files_path,'*.txt'));
Files_NO = length(DaFile_list);

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


Episode_NO=15;
start=76;
start0=75;
endd=start+Episode_NO-1;
Wake=[];
REM=[];
NREM=[];
prob=(0:1:15);
pro=prob';
i=1;
j=1;
l=1;

 for Episode=start:endd
        if Hypnogram(Episode)==1
            i=i+1;
            Wake=[Wake;pro(i,1)];
        else
            Wake=[Wake;pro(i,1)];
       
        end
  end
    for Episode=start:endd
        if Hypnogram(Episode)==2
            j=j+1;
            REM=[REM;pro(j,1)];
        else
            REM=[REM;pro(j,1)];
        end
    end
  for Episode=start:endd
       if Hypnogram(Episode)==3
            l=l+1;
            NREM=[NREM;pro(l,1)];
        else
            NREM=[NREM;pro(l,1)];
        end
   end

Wake=Wake';
REM=REM';
NREM=NREM';

w=[w;Wake];
r=[r;REM];
s=[s;NREM];

end
w(1,:)=[];
r(1,:)=[];
s(1,:)=[];
% wmean=mean(w);
% rmean=mean(r);
% smean=mean(s);
nonw=(w~=0);
nonr=(r~=0);
nons=(s~=0);
WAKEs=sum(nonw);
REMs=sum(nonr);
NREMs=sum(nons);
Wake_control=WAKEs/Files_NO;
REM_control=REMs/Files_NO;
NREM_control=NREMs/Files_NO;




w0=zeros(1,15);
r0=zeros(1,15);
s0=zeros(1,15);
[Filename, Files_path] = uigetfile('*.txt', 'Open Transition Data');

if Filename == 0
    return;
end

DaFile_list = dir(strcat(Files_path,'*.txt'));
Files_NO = length(DaFile_list);

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


Episode_NO=15;
start=76;
start0=75;
endd=start+Episode_NO-1;
Wake=[];
REM=[];
NREM=[];
prob=(0:1:15);
pro=prob';
i=1;
j=1;
l=1;

 for Episode=start:endd
        if Hypnogram(Episode)==1
            i=i+1;
            Wake=[Wake;pro(i,1)];
        else
            Wake=[Wake;pro(i,1)];
       
        end
  end
    for Episode=start:endd
        if Hypnogram(Episode)==2
            j=j+1;
            REM=[REM;pro(j,1)];
        else
            REM=[REM;pro(j,1)];
        end
    end
  for Episode=start:endd
       if Hypnogram(Episode)==3
            l=l+1;
            NREM=[NREM;pro(l,1)];
        else
            NREM=[NREM;pro(l,1)];
        end
   end

x=(1:length(Wake))';
Wake=Wake';
REM=REM';
NREM=NREM';

w0=[w0;Wake];
r0=[r0;REM];
s0=[s0;NREM];

end
w0(1,:)=[];
r0(1,:)=[];
s0(1,:)=[];

% wmean0=mean(w0);
% rmean0=mean(r0);
% smean0=mean(s0);
nonw0=(w0~=0);
nonr0=(r0~=0);
nons0=(s0~=0);
WAKEs0=sum(nonw0);
REMs0=sum(nonr0);
NREMs0=sum(nons0);
Wake_laser=WAKEs0/Files_NO;
REM_laser=REMs0/Files_NO;
NREM_laser=NREMs0/Files_NO;

x=(1:length(WAKEs));
subplot(1,3,1);
stairs(x,Wake_control,'k','LineWidth',2);
hold on 
stairs(x,Wake_laser,'green','LineWidth',2);
hold off
subplot(1,3,2);
stairs(x,REM_control,'k','LineWidth',2);
hold on 
stairs(x,REM_laser,'m','LineWidth',2);
hold off
subplot(1,3,3);
stairs(x,NREM_control,'k','LineWidth',2);
hold on 
stairs(x,NREM_laser,'b','LineWidth',2);
hold off
[hw1,pw1]=kstest2(Wake_control,Wake_laser, 0.05)
[hr1,pr1]=kstest2(REM_control,REM_laser, 0.05)
[hs1,ps1]=kstest2(NREM_control,NREM_laser, 0.05)
[hw2,pw2]=kstest2(Wake_control,Wake_laser, 0.01)
[hr2,pr2]=kstest2(REM_control,REM_laser, 0.01)
[hs2,ps2]=kstest2(NREM_control,NREM_laser, 0.01)
[hw3,pw3]=kstest2(Wake_control,Wake_laser, 0.001)
[hr3,pr3]=kstest2(REM_control,REM_laser, 0.001)
[hs3,ps3]=kstest2(NREM_control,NREM_laser, 0.001)