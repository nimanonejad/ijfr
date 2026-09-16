 
clear all
clc

addpath('functions')
addpath('data')

mtstream=RandStream('mt19937ar');
RandStream.setDefaultStream(mtstream); %USE RandStream.setGlobalStream(mtstream) if you get error.

N=1; 
LASTN=maxNumCompThreads(N);

ib=198601;
ie=202412;

mx=xlsread('mx.xls','Ark1');
mxc=mx(find(mx(:,end)==ib):find(mx(:,end)==ie),1:end-1);
for i=1:size(mxc,2)
    [irow,icol]=find(isnan(mxc(:,i)));
    while sum(isnan(mxc(:,i)),1)>0
        mxc(irow,i)=mxc(irow-1,i);
    end
end
clear mx

inc=size(mxc,2);
it=468;
vh=randn(it,1);
dphi0=0.01;
dphi1=0.96;
deta=0.10;
mcov0=cov(mxc);
dlam=1; %dlah=[1,1.5,0.5]
md=diag(diag(mcov0));
mcov=md+dlam*(mcov0-md);
mcov=(mcov+mcov')/2;
[mV,mD]=eig(mcov);
vd=diag(mD);
vd(vd<=0)=1e-8;
mcov=mV*diag(vd)*mV';
mcov=(mcov+mcov')/2;
mcor=corrcov(mcov);
vdx=triu(true(size(mcor)),1);
% mean(mcor(vdx))

ih=1;
ip=1; 
dalpha=1;
ml=combvec(0.94:0.01:1,50); 
vlambda=ml(1,:);
vgam=ml(2,:);

for i=2:it
    vh(i,1)=dphi0+dphi1*vh(i-1,1)+sqrt(deta)*randn(1,1);
end
ik=36;
vgc=(abs(max(0,vh-funcMax(vh,ik))+min(0,vh-funcMin(vh,ik)))>0.01)*1;  
mx=mvnrnd(zeros(1,inc),mcov,it);
vth=0.05*randn(inc,1);
vy=randn(inc,1);
for i=2:it
    vy(i,1)=dphi0+mx(i-1,:)*(vth.*vgc(i,1))+sqrt(deta)*randn(1,1);
end

vy=vy(ip+1:end,:);
vy=vy(ih:end,:);
mxlag=funcLag(mx,ip);
mxlag=mxlag(ip+1:end,:);

vy=funcMeanc(vy);
mxlag=funcMeanc(mxlag);

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
for k=1
    vh=vh(size(vh,1)-size(meps,1)+1:end,:);
    vh=funcMeanc(vh);
    moutc=funcDynamicRotation(meps,mpof,mpdf,mcvl,vh(1:end-ih,1),vlambda,vgam,ih,dalpha);
    eval(['save simulationl_',int2str(k),'.mat'])    
end
