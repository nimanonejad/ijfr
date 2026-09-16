
clear all
clc

addpath('functions')
addpath('data')

% mtstream=RandStream('mt19937ar');
% RandStream.setDefaultStream(mtstream);

mc=xlsread('results.xls','figure1_supp');

vtid=(1:420)';
xlimits=[1,420];
mc(1,2)=0;
vb=[0;diff((mc(:,2)>0)*1)];
ma=[vtid,vb];
vstart=find(ma(:,end)==1);
vend=(find(ma(:,end)==-1)-1)+2;
Recessions=[vtid(vstart,1),vtid(vend,1)];
subplot(3,2,1)
plot(mc(:,1))
axis tight;
recession_bars;
plot(vtid,mc(:,1))
axis tight; 
subplot(3,2,2)
plot(mc(:,3:6))
legend('TN','FP','FN','TP')
hold on
plot(xlim,[0.1,0.1])
hold on
plot(xlim,[0.8,0.8])

vtid=(1:420)';
xlimits=[1,420];
mc(1,2)=0;
vb=[0;diff((mc(:,9)>0)*1)];
ma=[vtid,vb];
vstart=find(ma(:,end)==1);
vend=(find(ma(:,end)==-1)-1)+2;
Recessions=[vtid(vstart,1),vtid(vend,1)];
subplot(3,2,3)
plot(mc(:,8))
axis tight;
recession_bars;
plot(vtid,mc(:,8))
axis tight; 
subplot(3,2,4)
plot(mc(:,10:13))
hold on
plot(xlim,[0.1,0.1])
hold on
plot(xlim,[0.8,0.8])

vtid=(1:420)';
xlimits=[1,420];
mc(1,2)=0;
vb=[0;diff((mc(:,16)>0)*1)];
ma=[vtid,vb];
vstart=find(ma(:,end)==1);
vend=(find(ma(:,end)==-1)-1)+2;
Recessions=[vtid(vstart,1),vtid(vend,1)];
subplot(3,2,5)
plot(mc(:,15))
axis tight;
recession_bars;
plot(vtid,mc(:,15))
axis tight; 
subplot(3,2,6)
plot(mc(:,17:20))
hold on
plot(xlim,[0.1,0.1])
hold on
plot(xlim,[0.8,0.8])

 