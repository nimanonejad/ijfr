 
clear all
clc

addpath('functions')
addpath('data')

%mtstream=RandStream('mt19937ar');
%RandStream.setDefaultStream(mtstream);

N=1; 
LASTN=maxNumCompThreads(N);

ih=1; %Forecast horizon
ip=1; 
dalpha=1;
ml=combvec(0.94:0.01:1,50); %The first is vector of lambda, and the second g=50. change if you want
 
vlambda=ml(1,:);
vgam=ml(2,:);

ib=198601;
ie=202412;
 
my=xlsread('my.xls');
mx=xlsread('mx.xls','Ark1');
mz=xlsread('mz.xls');
 
vtime=my(find(my(:,end)==ib):find(my(:,end)==ie),end);

vyc=my(find(my(:,end)==ib):find(my(:,end)==ie),3);
vpc=my(find(my(:,end)==ib):find(my(:,end)==ie),end-1)/100;
mxc=mx(find(mx(:,end)==ib):find(mx(:,end)==ie),1:end-1);
mzc=mz(find(mz(:,end)==ib):find(mz(:,end)==ie),1:end-1);

for i=1:size(mxc,2)
    [irow,icol]=find(isnan(mxc(:,i)));
    while sum(isnan(mxc(:,i)),1)>0
        mxc(irow,i)=mxc(irow-1,i);
    end
end

vp=vyc(2:end,1);
mplag=funcLag(vp,ip);
mplag=mplag(ip+1:end,:);
mplag=mplag(1:end-(ih-1),:);

vy=diff(log(vyc(:,1)));
mylag=funcLag(vy,ip);
mylag=mylag(ip+1:end,:);
mylag=mylag(1:end-(ih-1),:);

vp=vp(ip+1:end,:);
vp=vp(ih:end,:);

vy=vy(ip+1:end,:);
vy=vy(ih:end,:);

mxlag=funcLag(mxc(2:end,:),ip);
mxlag=mxlag(ip+1:end,:);
mxlag=mxlag(1:end-(ih-1),:);
 
vy=funcMeanc(vy);
mylag=funcMeanc(mylag);
mxlag=funcMeanc(mxlag);
mxlag=[mylag,mxlag];

cmodel=cell(size(mxlag,2)+1,1);
for i=1:size(cmodel,1)
    if i<size(cmodel,1)
        cmodel{i,1}=funcEstimateRLS(vy,mxlag(:,i),vlambda,vgam,dalpha);
    elseif i==size(cmodel,1)
        cmodel{i,1}=funcEstimateRLS(vy,1e-3*ones(size(vy,1),1),vlambda,vgam,dalpha);
    end
end

meps=zeros(size(cmodel{1,1}.vy,1),size(cmodel,1));
mpof=zeros(size(cmodel{1,1}.vy,1),size(cmodel,1));
mpdf=zeros(size(cmodel{1,1}.vy,1),size(cmodel,1));
mcvl=zeros(size(cmodel{1,1}.vy,1),size(cmodel,1));
mlam=zeros(size(cmodel{1,1}.vy,1),size(cmodel,1));
for i=1:size(cmodel,1)
    meps(:,i)=cmodel{i,1}.veps.^2;
    mpof(:,i)=cmodel{i,1}.vpof;  
    mpdf(:,i)=cmodel{i,1}.vpdf;  
    mcvl(:,i)=cmodel{i,1}.vcvl;  
    mlam(:,i)=cmodel{i,1}.vidx;  
end

mpof(:,end)=0;
meps(:,end)=cmodel{end,1}.vy.^2;
for k=[1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19] %this part does the loop over all predictors, which takes time
    vh=mzc(:,k);
    vh=vh(size(vh,1)-size(meps,1)+1:end,:);
    vh=funcMeanc(vh);
    moutc=funcDynamicRotation(meps,mpof,mpdf,mcvl,vh(1:end-ih,1),vlambda,vgam,ih,dalpha);
    eval(['save wti_',int2str(k),'.mat'])    
end
