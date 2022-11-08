clear
clc

r=zeros(1,15);
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
REM=[];
prob=(0:1:15);
pro=prob';
i=1;

 for Episode=start:endd
        if Hypnogram(Episode)==1 || Hypnogram(Episode)==3
            i=i+1;
            REM=[REM;pro(i,1)];
        else
            REM=[REM;pro(i,1)];
      end

 end

REM=REM';


r=[r;REM];

end
r(1,:)=[];
% rmean=mean(r);
nonr=(r~=0);
REMs=sum(nonr);
REM_control=REMs/Files_NO;





r0=zeros(1,15);

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
REM=[];
prob=(0:1:15);
pro=prob';
i=1;

 for Episode=start:endd
        if Hypnogram(Episode)==1 || Hypnogram(Episode)==3
            i=i+1;
            REM=[REM;pro(i,1)];
        else
            REM=[REM;pro(i,1)];
      end

 end

REM=REM';


r0=[r0;REM];

end
r0(1,:)=[];
%rmean0=mean(r0);
nonr0=(r0~=0);
REMs0=sum(nonr0);
REM_laser=REMs0/Files_NO;

x=(1:length(REMs));


stairs(x,REM_control,'k','LineWidth',2);
hold on 
stairs(x,REM_laser,'m','LineWidth',2);
hold off


[hr1,pr1]=kstest2(REM_control,REM_laser, 0.05)

[hr2,pr2]=kstest2(REM_control,REM_laser, 0.01)

[hr3,pr3]=kstest2(REM_control,REM_laser, 0.001)
