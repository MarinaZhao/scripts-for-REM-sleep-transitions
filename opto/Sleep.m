 function varargout = Sleep2(varargin)
% SLEEP2 MATLAB code for Sleep2.fig
% Author DONG Hui 20170106
% Email: lifesciences@hotmail.com
% for SleepSign format data
%      SLEEP2, by itself, creates a new SLEEP2 or raises the existing
%      singleton*.
%
%      H = SLEEP2 returns the handle to a new SLEEP2 or the handle to
%      the existing singleton*.
%
%      SLEEP2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLEEP2.M with the given input arguments.
%
%      SLEEP2('Property','Value',...) creates a new SLEEP2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sleep2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All ialphanputs are passed to Sleep2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sleep2

% Last Modified by GUIDE v2.5 15-Mar-2017 17:15:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Sleep2_OpeningFcn, ...
    'gui_OutputFcn',  @Sleep2_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Sleep2 is made visible.
function Sleep2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sleep2 (see VARARGIN)

% Choose default command line output for Sleep2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sleep2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sleep2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
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
    
    Trans_Timenum=datenum(Trans_Time);
    Trans_timerang(File)=(max(Trans_Timenum)-min(Trans_Timenum))*86400+Duration(end);
    Epoch_duration(File)=sum(Duration)/sum(Count);
    Sum_duration(File)=sum(Duration);
    
end

CheckRead=any(FirstLine-1);

CheckTime=any(round(Trans_timerang)/round(max(Trans_timerang))-1);

set(handles.edit7,'BackgroundColor','w');
set(handles.edit7,'ForegroundColor','k');


setappdata(handles.pushbutton1,'Epoch_duration',Epoch_duration);
setappdata(handles.pushbutton1,'Sum_duration',Sum_duration);
setappdata(handles.pushbutton1,'Sum_count',Sum_count);
duration=round(mean(Epoch_duration));
TotalTime=round(mean(Sum_duration));
set(handles.edit6,'String',[num2str(duration) 's']);
set(handles.edit7,'String',[num2str(TotalTime) 's']);
if CheckRead~=0
    set(handles.edit7,'BackgroundColor','g');
end

if CheckTime~=0
    set(handles.edit7,'ForegroundColor','r');
end


Episode_NO=max(Epsidose_max);

Epsiodenum=zeros(Episode_NO,Files_NO);

for Trial=1:Files_NO
    Trialtext=Epsiodetext{Trial};
    Episode_NO=length(Trialtext);
    for Episode=1:Episode_NO
        W='W';
        R='R';
        S='S';
        if Trialtext{Episode}==W
            Epsiodenum(Episode,Trial)=1;
        elseif Trialtext{Episode}==R
            Epsiodenum(Episode,Trial)=2;
        elseif Trialtext{Episode}==S
            Epsiodenum(Episode,Trial)=3;
        end
    end
end
Hypnogram=zeros(max(Sum_count),Files_NO);
for trial=1:Files_NO
    Epsiode_num=length(Epsiodetext{trial});
    Epsiodecount=Counttext{trial};
    i=1;
    for epsiode=1:Epsiode_num
        count=Epsiodecount(epsiode);
        Nexti=i+count-1;
        Hypnogram(i:Nexti,trial)=Epsiodenum(epsiode,trial);
        i=i+count;
    end
    setappdata(handles.pushbutton1,'Hypnogram',Hypnogram);
end
set(handles.edit1,'String',Files_path);
toc


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

colormapStates=[0,1,0;0.00449293991550803,0.995507061481476,0;0.00898587983101606,0.991014122962952,0;0.0134788192808628,0.986521184444428,0;0.0179717596620321,0.982028245925903,0;0.0224646981805563,0.977535307407379,0;0.0269576385617256,0.973042368888855,0;0.0314505770802498,0.968549430370331,0;0.0359435193240643,0.964056491851807,0;0.0404364578425884,0.959563553333283,0;0.0449293963611126,0.955070614814758,0;0.0494223348796368,0.950577676296234,0;0.0539152771234512,0.946084737777710,0;0.0584082156419754,0.941591799259186,0;0.0629011541604996,0.937098860740662,0;0.0673940926790237,0.932605922222138,0;0.0718870386481285,0.928112983703613,0;0.0763799771666527,0.923620045185089,0;0.0808729156851769,0.919127106666565,0;0.0853658542037010,0.914634108543396,0;0.0898587927222252,0.910141170024872,0;0.0943517312407494,0.905648231506348,0;0.0988446697592735,0.901155292987824,0;0.103337615728378,0.896662354469299,0;0.107830554246902,0.892169415950775,0;0.112323492765427,0.887676477432251,0;0.116816431283951,0.883183538913727,0;0.121309369802475,0.878690600395203,0;0.125802308320999,0.874197661876679,0;0.130295246839523,0.869704723358154,0;0.134788185358047,0.865211784839630,0;0.139281123876572,0.860718846321106,0;0.143774077296257,0.856225907802582,0;0.148267015814781,0.851732969284058,0;0.152759954333305,0.847240030765533,0;0.157252892851830,0.842747092247009,0;0.161745831370354,0.838254153728485,0;0.166238769888878,0.833761215209961,0;0.170731708407402,0.829268276691437,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;1,0,0;0.947368443012238,0,0.0526315793395042;0.894736826419830,0,0.105263158679008;0.842105269432068,0,0.157894730567932;0.789473712444305,0,0.210526317358017;0.736842095851898,0,0.263157904148102;0.684210538864136,0,0.315789461135864;0.631578922271729,0,0.368421047925949;0.578947365283966,0,0.421052634716034;0.526315808296204,0,0.473684221506119;0.473684221506119,0,0.526315808296204;0.421052634716034,0,0.578947365283966;0.368421047925949,0,0.631578922271729;0.315789461135864,0,0.684210538864136;0.263157904148102,0,0.736842095851898;0.210526317358017,0,0.789473712444305;0.157894730567932,0,0.842105269432068;0.105263158679008,0,0.894736826419830;0.0526315793395042,0,0.947368443012238;0,0,1];
try
    wcolor=getappdata(handles.pushbutton16,'wcolor');    
    colormapStates(1:21,1)=wcolor(1,1);
    colormapStates(1:21,2)=wcolor(1,2);
    colormapStates(1:21,3)=wcolor(1,3);
catch
    wcolor=[0 1 0];
    colormapStates(1:21,1)=wcolor(1,1);
    colormapStates(1:21,2)=wcolor(1,2);
    colormapStates(1:21,3)=wcolor(1,3);
    set(handles.pushbutton16,'BackgroundColor',wcolor);
    set(handles.pushbutton16,'ForegroundColor',1-wcolor);
    setappdata(handles.pushbutton16,'wcolor',wcolor);      
end
try
    Rcolor=getappdata(handles.pushbutton17,'Rcolor');
    colormapStates(22:41,1)=Rcolor(1,1);
    colormapStates(21:41,2)=Rcolor(1,2);
    colormapStates(21:41,3)=Rcolor(1,3);
catch
    Rcolor=[1 0 0];
    colormapStates(21:41,1)=Rcolor(1,1);
    colormapStates(21:41,2)=Rcolor(1,2);
    colormapStates(21:41,3)=Rcolor(1,3);
    set(handles.pushbutton17,'BackgroundColor',Rcolor);
    set(handles.pushbutton17,'ForegroundColor',1-Rcolor);
    setappdata(handles.pushbutton17,'Rcolor',Rcolor);    
end
try
    Ncolor=getappdata(handles.pushbutton18,'Ncolor');    
    colormapStates(42:64,1)=Ncolor(1,1);
    colormapStates(42:64,2)=Ncolor(1,2);
    colormapStates(42:64,3)=Ncolor(1,3);
catch
    Ncolor=[0 0 1];    
    colormapStates(42:64,1)=Ncolor(1,1);
    colormapStates(42:64,2)=Ncolor(1,2);
    colormapStates(42:64,3)=Ncolor(1,3);
    set(handles.pushbutton18,'BackgroundColor',Ncolor);
    set(handles.pushbutton18,'ForegroundColor',1-Ncolor);
    setappdata(handles.pushbutton18,'Ncolor',Ncolor);      
end
setappdata(handles.pushbutton2,'colormapStates',colormapStates);
Hypnogram=getappdata(handles.pushbutton1,'Hypnogram');
figure(1)
imagesc(Hypnogram');
colormap(colormapStates);
set(gca,'TickDir','out');
set(gca,'xtick',0:10:length(Hypnogram));
toc


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
Hypnogram=getappdata(handles.pushbutton1,'Hypnogram');
Trails_NO=length(Hypnogram(1,:));
Epsiode_NO=length(Hypnogram(:,1));
Temp=zeros(Epsiode_NO,1);

Epoch_duration=getappdata(handles.pushbutton1,'Epoch_duration');
Sum_duration=getappdata(handles.pushbutton1,'Sum_duration');
Sum_count=getappdata(handles.pushbutton1,'Sum_count');
duration=round(mean(Epoch_duration));

if str2num(get(handles.edit2,'String'))
    StartTime1=round(str2num(get(handles.edit2,'String'))/duration);
else
    StartTime1=round(Sum_count/2);
end
if str2num(get(handles.edit3,'String'))
    Time1=round(str2num(get(handles.edit3,'String'))/duration);
else
    Time1=1;
end
if str2num(get(handles.edit4,'String'))
    Time2=round(str2num(get(handles.edit4,'String'))/duration);
else
    Time2=2;
end
if str2num(get(handles.edit5,'String'))
    Time3=round(str2num(get(handles.edit5,'String'))/duration);
else
    Time3=2;
end

OnsetTime=StartTime1+Time1;
ExTime1=OnsetTime+Time2;
ExTime2=ExTime1+Time3;


TimeRange=[StartTime1,OnsetTime,ExTime1,ExTime2];

StartTime=TimeRange(1);
OnsetTime=TimeRange(2);
ExTime1=TimeRange(3);
ExTime2=TimeRange(4);
for Trails=1:Trails_NO
    for Trailsi=1:Trails_NO-Trails
        if sum(Hypnogram(StartTime:OnsetTime,Trailsi))< sum(Hypnogram(StartTime:OnsetTime,Trailsi+1))
            
            Temp=Hypnogram(:,Trailsi);
            Hypnogram(:,Trailsi)=Hypnogram(:,Trailsi+1);
            Hypnogram(:,Trailsi+1)=Temp;
        elseif sum(Hypnogram(StartTime:OnsetTime,Trailsi))== sum(Hypnogram(StartTime:OnsetTime,Trailsi+1)) & sum(Hypnogram(StartTime:ExTime1,Trailsi))< sum(Hypnogram(StartTime:ExTime1,Trailsi+1))
            
            Temp=Hypnogram(:,Trailsi);
            Hypnogram(:,Trailsi)=Hypnogram(:,Trailsi+1);
            Hypnogram(:,Trailsi+1)=Temp;
        elseif sum(Hypnogram(StartTime:OnsetTime,Trailsi))== sum(Hypnogram(StartTime:OnsetTime,Trailsi+1)) & sum(Hypnogram(StartTime:ExTime1,Trailsi))== sum(Hypnogram(StartTime:ExTime1,Trailsi+1)) & sum(Hypnogram(StartTime:ExTime2,Trailsi))== sum(Hypnogram(StartTime:ExTime2,Trailsi+1))
            Temp=Hypnogram(:,Trailsi);
            Hypnogram(:,Trailsi)=Hypnogram(:,Trailsi+1);
            Hypnogram(:,Trailsi+1)=Temp;
        end
        
    end
end
colormapStates=getappdata(handles.pushbutton2,'colormapStates');

figure(2)
imagesc(Hypnogram');
colormap(colormapStates);
set(gca,'xtick',0:10:length(Hypnogram));
set(gca,'TickDir','out');
toc


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hypnogram=getappdata(handles.pushbutton1,'Hypnogram');
colormapStates=getappdata(handles.pushbutton2,'colormapStates');
Sum_count=getappdata(handles.pushbutton1,'Sum_count');

Epoch_duration=getappdata(handles.pushbutton1,'Epoch_duration');
Sum_duration=getappdata(handles.pushbutton1,'Sum_duration');
Sum_count=getappdata(handles.pushbutton1,'Sum_count');
duration=round(mean(Epoch_duration));


if str2num(get(handles.edit2,'String'))
    StiOn=round(str2num(get(handles.edit2,'String'))/duration);
else
    StiOn=round(Sum_count/2);
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

for epoch=StiOn:size(Hypnogram_S,2)    
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


Trails_NO=length(Hypnogram(1,:));
Epsiode_NO=length(Hypnogram(:,1));
Wake=zeros(Epsiode_NO,1);
REM=zeros(Epsiode_NO,1);
NREM=zeros(Epsiode_NO,1);

for Trails=1:Trails_NO
    for Epsiode=1:Epsiode_NO
        if Hypnogram(Epsiode,Trails)==1
            Wake(Epsiode,1)=Wake(Epsiode,1)+1;
        elseif Hypnogram(Epsiode,Trails)==2
            REM(Epsiode,1)=REM(Epsiode,1)+1;
        elseif Hypnogram(Epsiode,Trails)==3
            NREM(Epsiode,1)=NREM(Epsiode,1)+1;
        end
    end
    
end
Wake=(Wake/Trails_NO);
NREM=(NREM/Trails_NO);
REM=(REM/Trails_NO);
x=(1:length(Wake))';

Wake_CI95P=(Wake+1.96*sqrt(Wake.*(1-Wake)/Trails_NO))*100;
Wake_CI95N=(Wake-1.96*sqrt(Wake.*(1-Wake)/Trails_NO))*100;

REM_CI95P=(REM+1.96*sqrt(REM.*(1-REM)/Trails_NO))*100;
REM_CI95N=(REM-1.96*sqrt(REM.*(1-REM)/Trails_NO))*100;

NREM_CI95P=(NREM+1.96*sqrt(NREM.*(1-NREM)/Trails_NO))*100;
NREM_CI95N=(NREM-1.96*sqrt(NREM.*(1-NREM)/Trails_NO))*100;

Wake=Wake*100;
NREM=NREM*100;
REM=REM*100;
try
    Wcolor=getappdata(handles.pushbutton16,'wcolor');
catch
    Wcolor=[0 1 0];
end
try
    Rcolor=getappdata(handles.pushbutton17,'Rcolor');
catch
    Rcolor=[1 0 0];
end
try
    Ncolor=getappdata(handles.pushbutton18,'Ncolor');
catch
    Ncolor=[0 0 1];
end
if str2num(get(handles.edit20,'String'))
    
    facealpha=str2num(get(handles.edit20,'String'));
else
    facealpha=0.4;
end
try
close 3
catch
end

figure(3)
patch([x;flipud(x)],[Wake_CI95P;flipud(Wake_CI95N)],Wcolor,'FaceColor',Wcolor,'EdgeA',0,'FaceAlpha',facealpha);
line(x,Wake,'color',Wcolor,'linewidth',2);
hold on
patch([x;flipud(x)],[REM_CI95P;flipud(REM_CI95N)],Rcolor,'FaceColor',Rcolor,'EdgeA',0,'FaceAlpha',facealpha);
line(x,REM,'color',Rcolor,'linewidth',2);
hold on
patch([x;flipud(x)],[NREM_CI95P;flipud(NREM_CI95N)],Ncolor,'FaceColor',Ncolor,'EdgeA',0,'FaceAlpha',facealpha);
line(x,NREM,'color',Ncolor,'linewidth',2);
hold on
line(x,Cumulative_Probability,'color',Ncolor,'linewidth',2);



% xticklabename=num2str(x(round(linspace(1,length(x),9)))*4);
% set(gca, 'xticklabel',xticklabename);
% set(gca,'TickDir','out');
% set(gcf,'Renderer','painters');
% set(hw,'EdgeColor','none');
% set(hr,'EdgeColor','none');
% set(hn,'EdgeColor','none');










function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file, path] = uigetfile({'*.txt'}, 'Open EEG Data');
DataFile=[path file];
if file==0
    return
end
set(handles.edit9,'String',DataFile);

% [~,textdata ,~] =  xlsread(DataFile);

[Timepoint,EEG,EMG,Ca] =  textread(DataFile,'%s %f %f %f ','delimiter','\t','headerlines',19);

setappdata(handles.pushbutton5,'Timepoint',Timepoint);
setappdata(handles.pushbutton5,'EEG',EEG);
setappdata(handles.pushbutton5,'EMG',EMG);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
Timepoint=getappdata(handles.pushbutton5,'Timepoint');
EEG=getappdata(handles.pushbutton5,'EEG');
EMG=getappdata(handles.pushbutton5,'EMG');
Timenum=datenum(Timepoint);
timerang=(max(Timenum)-min(Timenum))*86400;

%%
EEG_length=length(EEG);
Frequency_sample=round(EEG_length/timerang);
EEG_time=EEG_length/Frequency_sample;
set(handles.edit10,'String',[num2str(Frequency_sample) 'Hz']);
set(handles.edit11,'String',[num2str(EEG_time) 's']);

try
    Windows_fft=str2num(get(handles.popupmenu1,'value'));
    switch Windows_fft
        case 128
            Windows_overlap=100;
        case 256
            Windows_overlap=200;
        case 512
            Windows_overlap=500;
        case 1024
            Windows_overlap=1000;
        case 2046
            Windows_overlap=2000;
    end
catch
    Windows_fft=1024;
    Windows_overlap=1000;
end
Frequency_out=0.5:0.125:25;

%%
figure(1)
subplot(2,1,1)
plot(EEG)
set(gca,'TickDir','out');
subplot(2,1,2)
plot(EMG)
set(gca,'TickDir','out');

%%
%%
[~,F,T,P]=spectrogram(EEG,Windows_fft,Windows_overlap,Frequency_out,Frequency_sample,'yaxis');
%P=flipud(P);
figure(2)
imagesc(T,-F,P);
colormap(jet);
ylabel('Frequency (Hz)');
xlabel('Time (s)');
set(gca,'TickDir','out');
toc



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.tif';'*.jpg';'*.bmp';'*.png'},'Select Image','MultiSelect','on');
if pathname==0
    return
end
set(handles.edit12,'String',pathname);
image_num = length(filename);
set(handles.edit14,'String',num2str(image_num));
%��ȡͼ��
h=waitbar(0,'Reading Image'); %��ʾ��ʼ����
set(findall(h, 'type' , 'patch' ), 'facecolor' , 'g','edgecolor','b' )

for image_order = 1:image_num
    image_name = filename{image_order};
    image =  imread(strcat(pathname,image_name));
    batchphoto{image_order}=image;
    waitbar(image_order/image_num,h,['Reading Image' num2str(image_order) '/' num2str(image_num)]);
end
close(h);
setappdata(handles.pushbutton7,'batchphoto',batchphoto);
setappdata(handles.pushbutton7,'filename',filename);



% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
batchphoto=getappdata(handles.pushbutton7,'batchphoto');
filename=getappdata(handles.pushbutton7,'filename');
image_num = length(filename);%��ȡͼ��������
%������Сͼ��
image_length=zeros(image_num,1);
image_width=zeros(image_num,1);
image_rgbtatio=zeros(image_num,1);
for j=1:image_num
    [image_length(j),image_width(j),image_rgbtatio(j)]=size(batchphoto{j});
end
image_lengthmin=min(image_length);
image_widthmin=min(image_width);
image_rgbtatiomin=min(image_rgbtatio);
h=waitbar(0,'Binaryzation');
set(findall(h, 'type' , 'patch' ), 'facecolor' , 'g','edgecolor','b' )

if get(handles.radiobutton1,'value');
    for j=1:image_num
        [image_l,image_w,image_r]=size(batchphoto{j});
        if image_r==4
            batchphoto{j} =batchphoto{j}(:,:,1:3);
        end
        batchphoto{j}=rgb2gray(batchphoto{j});%�Ҷ�
        thresh=graythresh(batchphoto{j});%������ֵ
        batchphoto{j}=im2bw(batchphoto{j},thresh);%��ֵ��
        batchphoto{j}=~batchphoto{j};%ȡ��
        %batchphoto{j}= double(batchphoto{j}); %double��
        image_name = filename{j};
        waitbar(j/image_num,h,['Binaryzation' num2str(j) '/' num2str(image_num)]);
        
    end
else if get(handles.radiobutton1,'value');
        for j=1:image_num
            [image_l,image_w,image_r]=size(batchphoto{j});
            if image_r==4
                batchphoto{j} =batchphoto{j}(:,:,1:3);
            end
            batchphoto{j}=rgb2gray(batchphoto{j});%�Ҷ�
            thresh=graythresh(batchphoto{j});%������ֵ
            batchphoto{j}=im2bw(batchphoto{j},thresh);%��ֵ��
            %batchphoto{j}= double(batchphoto{j}); %double��
            image_name = filename{j};
            waitbar(j/image_num,h,['Binaryzation' num2str(j) '/' num2str(image_num)]);
            
        end
    end
end
close(h);
%�ۼ�ͼ��
h=waitbar(0,'Accumulation');
set(findall(h, 'type' , 'patch' ), 'facecolor' , 'g','edgecolor','b' )

heatmapdata=zeros(image_lengthmin,image_widthmin);%��ʼ��heatmapdata
for j=1:image_num
    for p=1:image_lengthmin
        for q=1:image_widthmin
            heatmapdata(p,q)=heatmapdata(p,q)+batchphoto{j}(p,q);
        end
    end
    waitbar(j/image_num,h,['Accumulation' num2str(j) '/' num2str(image_num)]);
end
close(h);

hot=max(max(heatmapdata));
set(handles.edit13,'String',num2str(hot));
image_colormap=[1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;1,1,1;0.973958313465118,0.973958313465118,1;0.947916686534882,0.947916686534882,1;0.921875000000000,0.921875000000000,1;0.895833313465118,0.895833313465118,1;0.869791686534882,0.869791686534882,1;0.843750000000000,0.843750000000000,1;0.817708313465118,0.817708313465118,1;0.791666626930237,0.791666626930237,1;0.765625000000000,0.765625000000000,1;0.739583313465118,0.739583313465118,1;0.713541626930237,0.713541626930237,1;0.687500000000000,0.687500000000000,1;0.661458313465118,0.661458313465118,1;0.635416626930237,0.635416626930237,1;0.609375000000000,0.609375000000000,1;0.583333313465118,0.583333313465118,1;0.291666656732559,0.291666656732559,1;0,0,1;0,0.125000000000000,1;0,0.250000000000000,1;0,0.375000000000000,1;0,0.500000000000000,1;0,0.625000000000000,1;0,0.750000000000000,1;0,0.875000000000000,1;0,1,1;0.100000001490116,1,0.899999976158142;0.200000002980232,1,0.800000011920929;0.300000011920929,1,0.699999988079071;0.400000005960465,1,0.600000023841858;0.500000000000000,1,0.500000000000000;0.600000023841858,1,0.400000005960465;0.699999988079071,1,0.300000011920929;0.800000011920929,1,0.200000002980232;0.899999976158142,1,0.100000001490116;1,1,0;1,0.937500000000000,0;1,0.875000000000000,0;1,0.812500000000000,0;1,0.750000000000000,0;1,0.687500000000000,0;1,0.625000000000000,0;1,0.562500000000000,0;1,0.500000000000000,0;1,0.437500000000000,0;1,0.375000000000000,0;1,0.312500000000000,0;1,0.250000000000000,0;1,0.187500000000000,0;1,0.125000000000000,0;1,0.0625000000000000,0;1,0,0;0.899999976158142,0,0;0.800000011920929,0,0;0.699999988079071,0,0;0.600000023841858,0,0;0.500000000000000,0,0];
figure(1)
imagesc(heatmapdata);
colormap(image_colormap);
set(gca,'TickDir','out');
image_colormap=colormap;

function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton1,'value',1);
set(handles.radiobutton2,'value',0);

% --- Executes on button press in radiobutton1.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton1,'value',0);
set(handles.radiobutton2,'value',1);

function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton3,'value',1);
set(handles.radiobutton4,'value',0);

% --- Executes on button press in radiobutton1.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
set(handles.radiobutton3,'value',0);
set(handles.radiobutton4,'value',1);


function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Spikefile, Spikepath] = uigetfile('*.mat', 'Open Spike Data');
SpikeDataFile=[Spikepath Spikefile];

if Spikefile==0
    return
end

set(handles.edit16,'String',SpikeDataFile);

load (SpikeDataFile);
vararry=whos('-file',SpikeDataFile);
varyNO=length(vararry);


for i=1:varyNO
    if ~isempty(strfind(vararry(i).name,'EEG'))
        eval(['EEG=',vararry(i).name,'.values;']);
        
    elseif ~isempty(strfind(vararry(i).name,'EMG'))
        eval(['EMG=',vararry(i).name,'.values;']);
        
    elseif ~isempty(strfind(vararry(i).name,'Ca'))&& isempty(strfind(vararry(i).name,'EEG')) && isempty(strfind(vararry(i).name,'EMG')) && isempty(strfind(vararry(i).name,'Keyboard'))
        eval(['Ca=',vararry(i).name,'.values;']);
        
    end
end
if isempty(EEG) || isempty(EMG)
    set(handles.edit16,'String','NO Data');
else if ~(isempty(EEG) || isempty(EMG))
        set(handles.edit16,'String',SpikeDataFile);
    end
end

setappdata(handles.pushbutton10,'EEG',EEG);
setappdata(handles.pushbutton10,'EMG',EMG);
setappdata(handles.pushbutton10,'Ca',Ca);


% EEG=EEG_ori.values;
% EMG=EMG_ori.values;
% Ca=Ca_ori.values;



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname,filterindex] =uiputfile('*.txt','Save as');
Textname=[pathname filename];


if filename==0
    return
end

EEG=getappdata(handles.pushbutton10,'EEG');
EMG=getappdata(handles.pushbutton10,'EMG');
try
    Ca=getappdata(handles.pushbutton10,'Ca');
catch
end
if isempty(EEG) || isempty(EMG)
    return
    
elseif ~isempty(EEG) && ~isempty(EMG)&&~isempty(Ca)
    EEG_length=length(EEG);
    EMG_length=length(EMG);
    Ca_length=length(Ca);
    fid=fopen(Textname,'wt');
    h=waitbar(0,'Writing');
    set(findall(h, 'type' , 'patch' ), 'facecolor' , 'g','edgecolor','b' )
    tic
    for i=1:EEG_length
        fprintf(fid,'%f\t%f\t%f\t\n',EEG(i)/2,EMG(i),Ca(i)/20);
        
        tneed=ceil((toc*EEG_length/i-toc)/60);
        waitbar(i/EEG_length,h,['Writing ' num2str(ceil(i/EEG_length*10000)/100) '%   abount ' num2str(tneed) ' minutes remaining']);
        
    end
    fclose(fid);
    close(h);
    
elseif ~isempty(EEG) && ~isempty(EMG)&& isempty(Ca)
    EEG_length=length(EEG);
    EMG_length=length(EMG);
    fid=fopen(Textname,'wt');
    h=waitbar(0,'Writing');
    set(findall(h, 'type' , 'patch' ), 'facecolor' , 'g','edgecolor','b' )
    tic
    for i=1:EEG_length
        fprintf(fid,'%f\t%f\t%f\t\n',EEG(i)/2,EMG(i));
        
        tneed=ceil((toc*EEG_length/i-toc)/60);
        waitbar(i/EEG_length,h,['Writing ' num2str(ceil(i/EEG_length*10000)/100) '%   abount ' num2str(tneed) ' minutes remaining']);
    end
    fclose(fid);
    close(h);
    set(handles.edit17,'String',Textname);
    
end

function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FFTfile, FFTpath] = uigetfile('*.xls;*xlsx', 'Open FFT Data');
if FFTfile==0
    return
end
FFTDataFile=[FFTpath FFTfile];
FFTdata=xlsread(FFTDataFile);
setappdata(handles.pushbutton13,'FFTdata',FFTdata);

set(handles.edit19,'String',FFTDataFile);

function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FFTdata=getappdata(handles.pushbutton13,'FFTdata');
meanheatmap=mean(mean(FFTdata));
FFTheatmap=FFTdata/meanheatmap;
FFTheatmap=FFTheatmap.^0.2;
if  get(handles.radiobutton3,'value')
    FFTheatmap=rot90(FFTheatmap);
elseif  get(handles.radiobutton4,'value')
    FFTheatmap=flipud(FFTheatmap);
end
figure(1)
imagesc(FFTheatmap);
set(gca,'TickDir','out');


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dialogtext={'DONG Hui','lifesciences@hotmail.com','Sleep2 v1.0'};
h=dialog('name','About Us','position',[200 200 200 200]);
movegui(h, 'center')
uicontrol('parent',h,'style','text','string',dialogtext,'position',[5 40 200 100],'fontsize',10);
uicontrol('parent',h,'style','pushbutton','position',[75 50 50 20],'string','OK','callback','delete(gcbf)');

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wcolor=uisetcolor('Set Wake Color');
setappdata(handles.pushbutton16,'wcolor',wcolor);
set(handles.pushbutton16,'BackgroundColor',wcolor);
set(handles.pushbutton16,'ForegroundColor',1-wcolor);

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Rcolor=uisetcolor('Set REM Sleep Color');
setappdata(handles.pushbutton17,'Rcolor',Rcolor);
set(handles.pushbutton17,'BackgroundColor',Rcolor);
set(handles.pushbutton17,'ForegroundColor',1-Rcolor);

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ncolor=uisetcolor('Set NREM Sleep Color');
setappdata(handles.pushbutton18,'Ncolor',Ncolor);
set(handles.pushbutton18,'BackgroundColor',Ncolor);
set(handles.pushbutton18,'ForegroundColor',1-Ncolor);



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Spikefile, Spikepath] = uigetfile('*.mat', 'Open Spike Data');
tic
if Spikepath==0
    return;
end
SpikeDataFile=[Spikepath,Spikefile];
load (SpikeDataFile);
vararry=whos('-file',SpikeDataFile);
varyNO=length(vararry);
for i=1:varyNO
    if ~isempty(strfind(vararry(i).name,'EEG'))
       eval(['EEG=',vararry(i).name,'.values;']);
       eval(['Frequency_sample=1/',vararry(i).name,'.interval;']);
    elseif ~isempty(strfind(vararry(i).name,'EMG'))
        eval(['EMG=',vararry(i).name,'.values;']);
        
    elseif ~isempty(strfind(vararry(i).name,'Ca'))&&isempty(strfind(vararry(i).name,'EEG'))&&isempty(strfind(vararry(i).name,'EMG'))&&isempty(strfind(vararry(i).name,'Keyboard'))
        eval(['Ca=',vararry(i).name,'.values;']);        
    end    
end

EEG_length=length(EEG);
EEG_time=EEG_length/Frequency_sample;

set(handles.edit22,'String',[num2str(Frequency_sample) 'Hz']);
set(handles.edit23,'String',[num2str(EEG_time) 's']);

setappdata(handles.pushbutton19,'EEG',EEG);
setappdata(handles.pushbutton19,'EMG',EMG);
setappdata(handles.pushbutton19,'Frequency_sample',Frequency_sample);
toc

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
EEG=getappdata(handles.pushbutton19,'EEG');
EMG=getappdata(handles.pushbutton19,'EMG');
Frequency_sample=getappdata(handles.pushbutton19,'Frequency_sample');


%%


try
    Windows_fft=str2num(get(handles.popupmenu2,'value'));
    switch Windows_fft
        case 128
            Windows_overlap=100;
        case 256
            Windows_overlap=200;
        case 512
            Windows_overlap=500;
        case 1024
            Windows_overlap=1000;
        case 2046
            Windows_overlap=2000;
    end
catch
    Windows_fft=1024;
    Windows_overlap=1000;
end
Frequency_out=0.5:0.125:25;

%%
figure(1)
subplot(2,1,1)
plot(EEG)
set(gca,'TickDir','out');

ylabel('EEG');

subplot(2,1,2)
plot(EMG)
set(gca,'TickDir','out');
ylabel('EMG');

%%
[~,F,T,P]=spectrogram(EEG,Windows_fft,Windows_overlap,Frequency_out,Frequency_sample,'yaxis');
%P=flipud(P);
figure(2)
imagesc(T,-F,P);
colormap(jet);
ylabel('Frequency (Hz)');
xlabel('Time (s)');
set(gca,'TickDir','out');
toc
