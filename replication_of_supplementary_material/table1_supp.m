
clear all
clc

addpath('functions')
addpath('data')

% mtstream=RandStream('mt19937ar');
% RandStream.setDefaultStream(mtstream);

vbeg=199001;
vend=202412;    %remember to change, 202412 for 1990-2024 out-of-sample period.
% vend=201912;  %remember to change, 201912 for 1990-2019 out-of-sample period.

load wti_sma_bma_1
dalpha=1;
mpofc(:,1)=mean(mpof,2);
mpofc(:,2)=median(mpof,2);
vpm=ones(1,size(mpdf,2))/size(mpdf,2);
mpm=zeros(size(mpof));
mbic=zeros(size(mpof));
mpm(1,:)=vpm;
vdx=zeros(size(mpof,1),1);
vbc=zeros(size(mpof,1),1);
for i=1:size(mpdf,1)
    vsum=sum(vpm.^dalpha,2);
    vpm=(vpm.^dalpha)./vsum;
    [~,vdx(i,1)]=max(vpm);
    vpofc=mpof(i,:);
    [~,imin]=min(vpofc);
    [~,imax]=max(vpofc);
    vpofc(:,imin)=[];
    vpofc(:,imax)=[];
    mpofc(i,3)=mean(vpofc,2);
    mpofc(i,4)=sum(mpof(i,:).*vpm,2);
    mpofc(i,5)=mpof(i,vdx(i,1));
    mpm(i,:)=(mpdf(i,:).*vpm)./sum(mpdf(i,:).*vpm,2);
    vpm=mpm(i,:);  
end

meta=(repmat(vy,1,size(mpofc,2))-mpofc).^2;
vtimec=vtime(size(vtime,1)-size(meta,1)+1:end,1);
is=find(vtimec(:,1)==vbeg(1,1),1);ie=find(vtimec(:,1)==vend(1,1),1); 
metas=meta(is:ie,:);
mpofs=mpofc(is:ie,:);
vys=vy(is:ie,:);
vcvlb=mcvl(is:ie,end);
vylc=mylag(is:ie,end);

load wti_bic_1
vtimec=vtime(size(vtime,1)-size(meta,1)+1:end,1);
is=find(vtimec(:,1)==vbeg(1,1),1);ie=find(vtimec(:,1)==vend(1,1),1); 
metax=meta(is:ie,:);
mpofx=mpof(is:ie,:);

load wti_ridge_1
ig=1;
vtimec=vtime(size(vtime,1)-size(meta,1)+1:end,1);
is=find(vtimec(:,1)==vbeg(1,1),1);ie=find(vtimec(:,1)==vend(1,1),1); 
metad=meta(is:ie,ig);
mpofd=mpof(is:ie,ig);
 
myhac=[mpofs,mpofx,mpofd];
metac=[metas,metax,metad];
vyhab=zeros(size(myhac,1),1);
vetab=vys.^2;

vtimec=vtime(size(vtime,1)-size(metac,1)+1:end,1);
is=find(vtimec(:,1)==vbeg(1,1),1);ie=find(vtimec(:,1)==vend(1,1),1); 
 
mplag=mplag(size(mplag,1)-size(metac,1)+1:end,1);
vp=vp(size(vp,1)-size(metac,1)+1:end,1);
myhad=repmat(mplag,1,size(myhac,2)).*exp(myhac);
vyhab=mplag.*exp(vyhab);
  
mquant=zeros(7,3);
for i=1:size(myhad,2);
    vetac=(vp-myhad(:,i)).^2;
    vetab=(vp-vyhab).^2;
    mquant(i,:)=[mean(vetac,1)./mean(vetab,1),funcCW(vyhab,myhad(:,i),vp),funcDM([vetab,vetac],1)];
end
mquant

