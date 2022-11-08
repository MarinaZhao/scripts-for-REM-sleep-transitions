clear
clc

w=zeros(1,30);
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


Episode_NO=30;
start=76;
start0=75;
endd=start+Episode_NO-1;
Wake=[];
prob=(0:1:30);
pro=prob';
i=1;

 for Episode=start:endd
        if Hypnogram(Episode)==2 || Hypnogram(Episode)==3
            i=i+1;
            Wake=[Wake;pro(i,1)];
        else
            Wake=[Wake;pro(i,1)];
      end

 end

Wake=Wake';


w=[w;Wake];

end
w(1,:)=[];
% wmean=mean(w);
nonw=(w~=0);
WAKEs=sum(nonw);
Wake_control=WAKEs/Files_NO;
% Wake_control=wmean./Episode_NO;



w0=zeros(1,30);

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


Episode_NO=30;
start=76;
start0=75;
endd=start+Episode_NO-1;
Wake=[];
prob=(0:1:30);
pro=prob';
i=1;

 for Episode=start:endd
        if Hypnogram(Episode)==2 || Hypnogram(Episode)==3
            i=i+1;
            Wake=[Wake;pro(i,1)];
        else
            Wake=[Wake;pro(i,1)];
      end

 end

Wake=Wake';


w0=[w0;Wake];

end
w0(1,:)=[];
% wmean0=mean(w0);


nonw0=(w0~=0);
WAKEs0=sum(nonw0);
Wake_laser=WAKEs0/Files_NO;


x=(1:length(WAKEs));


stairs(x,Wake_control,'k','LineWidth',2);
hold on 
stairs(x,Wake_laser,'green','LineWidth',2);
hold off


[hw1,pw1]=kstest2(Wake_control,Wake_laser, 0.05)

[hw2,pw2]=kstest2(Wake_control,Wake_laser, 0.01)

[hw3,pw3]=kstest2(Wake_control,Wake_laser, 0.001)
