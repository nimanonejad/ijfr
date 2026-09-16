 
clear all
clc

addpath('functions')
addpath('data')

%mtstream=RandStream('mt19937ar');
%RandStream.setDefaultStream(mtstream);

N=1; 
LASTN=maxNumCompThreads(N);

ih=1;
ip=1; 

ib=198601;
ie=202412;
 
my=xlsread('my.xls');
mx=xlsread('mx.xls','Ark1');
mz=xlsread('mz.xls');
 
vtime=my(find(my(:,end)==ib):find(my(:,end)==ie),end);

vyc=my(find(my(:,end)==ib):find(my(:,end)==ie),3);
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

cmodel=cell(size(mxlag,2),1);
for i=1:size(mxlag,2)+1;
    if i==size(mxlag,2)+1
        cmodel{i,1}=funcRegress(vy,ones(size(vy,1),1),2*12);
    else
        cmodel{i,1}=funcRegress(vy,mxlag(:,i),2*12);
    end
end

mepsc=zeros(size(cmodel{1,1}.vys,1),size(cmodel,1));
mresc=zeros(size(cmodel{1,1}.vys,1),size(cmodel,1));
mpofc=zeros(size(cmodel{1,1}.vys,1),size(cmodel,1));
mpdfc=zeros(size(cmodel{1,1}.vys,1),size(cmodel,1));
maicc=zeros(size(cmodel{1,1}.vys,1),size(cmodel,1));
mbicc=zeros(size(cmodel{1,1}.vys,1),size(cmodel,1));
for i=1:size(cmodel,1)
    mepsc(:,i)=cmodel{i,1}.veps.^2;
    mresc(:,i)=cmodel{i,1}.veps;
    mpofc(:,i)=cmodel{i,1}.vpof;  
    mpdfc(:,i)=cmodel{i,1}.vpdf;  
    maicc(:,i)=cmodel{i,1}.vaic;  
    mbicc(:,i)=cmodel{i,1}.vbic;  
end
mpofc(:,end)=0;   
mresc(:,end)=cmodel{end,1}.vys.^2;
mepsc(:,end)=cmodel{end,1}.vys.^2;

mpof=zeros(size(mpofc,1),1);
mpdf=zeros(size(mpdfc,1),1);
meta=zeros(size(mpofc,1),1);
mqcc=zeros(size(mpofc,1),1);
for i=1:size(mepsc,1);
    [~,vdx]=sort(mbicc(i,:)); 
    mqcc(i,:)=vdx(1,1);
    mpof(i,1)=mpofc(i,vdx(1,1));
    mpdf(i,1)=mpdfc(i,vdx(1,1));
    meta(i,1)=mepsc(i,vdx(1,1));       
end
eval(['save wti_bic_',int2str(1),'.mat'])

vlambda=100;
for i=1:size(vlambda,2);
    i
    mridge=funcRidge(vy,mxlag,2*12,vlambda(1,i));
    meta(:,i)=mridge.veps.^2;
    mpof(:,i)=mridge.vpof;
end
eval(['save wti_ridge_',int2str(1),'.mat']) 
