advselect={};
animalnum=6;
for y=1:animalnum
    prompt = 'input address\n';
addr = input(prompt,'s');
% addr=
% % 96-3.8375.xlsx
% % 641-4.05.xlsx
% % 641-4.08.xlsx
% % 642-3.94.xlsx
% % 642-4.0.xlsx
% % 642-4.10.xlsx

prompt = 'input states address\n';
states = input(prompt,'s');
% states=
% % 96-3.8375-states.xlsx
% % 641-4.05-states.xlsx
% % 641-4.08-states.xlsx
% % 642-3.94-states.xlsx
% % 642-4.0-states.xlsx
% % 642-4.10-states.xlsx

prompt = 'input sheet number\n';
z = input(prompt);
% 8;

for Z=1:z


prompt = 'input sheet name\n';
A = input(prompt,'s');
% A=Sheet1;

B='E2:F50';

timestamp=xlsread(addr,A);
minmax=xlsread(states,A,B);
min=minmax(:,1);
max=minmax(:,2);
 
[t,j]=size(timestamp);


[n,n1]=size(min);


for v=1:n
    realmin=min(v,1);
    realmax=max(v,1);
for s=1:j
selectimes=[];
for i=1:t
if timestamp(i,s) >= realmin && timestamp(i,s) <= realmax 
    selectimes=[selectimes;timestamp(i,s)];
end
end
advselect=[advselect,selectimes];
end

end

end
end