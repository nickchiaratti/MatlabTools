clear all
close all
clc
count=2000;
data=zeros(count,4);
t=1:count;
k=0;
p=0;

S=serial('COM7','BaudRate',115200);
fopen(S);

for i=1:10
    str=fgets(S);
end
tic;
 for i=1:count
  str=fgets(S);
  D=sscanf(str,'%d');
    if (numel(D)>0)
        for j=1:numel(D)
           data(i,j)=D(j);
        end
    end
    
  p=p+1;
    if p == 500
       p=0;
       toc
       pause(1e-100)
    end
    
 end
Duration=toc
fclose(S)
delete(S)
clear S

figure;
subplot(4,1,1)
title('Gyro X')
plot(t,data(:,1),'r');

subplot(4,1,2)
title('Gyro Y')
plot(t,data(:,2),'g');

subplot(4,1,3)
title('Gyro Z')
plot(t,data(:,3));

subplot(4,1,4)
title('Temp')
plot(t,data(:,4));

save('Data.mat','data','Duration')

