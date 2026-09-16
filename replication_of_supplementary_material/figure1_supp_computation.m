
clear all
clc

% mtstream=RandStream('mt19937ar');
% RandStream.setDefaultStream(mtstream);

addpath('functions')
addpath('data')

N=1; 
LASTN=maxNumCompThreads(N);
for k=1
   
    eval(['load simulation_',int2str(k),'.mat']) 

    dalpha=1;
    mml=combvec([5e-1,1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-10],1)';
    vdm=zeros(size(mml,1),1);
    vdm(end,1)=0;

    ampr=zeros(size(moutc.vpdfb,1),4,size(mml,1));
    amqn=zeros(size(moutc.vpdfb,1),14,size(mml,1));
    mpyt=zeros(size(moutc.vpdfb,1),size(mml,1));
    myha=zeros(size(moutc.vpdfb,1),size(mml,1));
    mcrp=zeros(size(moutc.vpdfb,1),size(mml,1));
    mpr=zeros(size(moutc.vpdfb,1),4);
    mqb=zeros(size(moutc.vpdfb,1),14);
    mqn=zeros(size(moutc.vpdfb,1),14);
    mpm=zeros(size(mpyt));
    vdx=zeros(size(moutc.vpdfb,1),1);
    vyhac=zeros(size(moutc.vpdfb,1),1);
    vpdfc=zeros(size(moutc.vpdfb,1),1);
    for i=1:size(mml,1)
        mout=funcLearning(moutc,vy,mml(i,1),mml(i,2),vdm(i,1));
        ampr(:,:,i)=mout.mprir;
        amqn(:,:,i)=mout.mqunt;
        mpyt(:,i)=mout.vpdfc;
        myha(:,i)=mout.vyhac;
    end

    vcvlb=mout.vcvlb;
    vpm=ones(1,size(mpyt,2))./size(mpyt,2);
    mpm(1,:)=vpm;
    mpyt(1,:)=1e-4;
    m=0;
    for i=1:size(mpyt,1)
        vsum=sum(vpm.^dalpha,2);
        vpm=(vpm.^dalpha)./vsum;
        mpm(i,:)=vpm;
        [~,vdx(i,1)]=max(vpm);
        if mean(vpm,2)==vpm(1,1)
           vdx(i,1)=size(mml,1);
           m=m+1;
        end
           %mpr(i,:)=squeeze(ampr(i,:,vdx(i,1)));
           mqb(i,:)=squeeze(amqn(i,:,vdx(i,1)));
           %vyhac(i,1)=myha(i,vdx(i,1));
           %vpdfc(i,1)=mpyt(i,vdx(i,1));
           mpr(i,:)=sum(squeeze(ampr(i,:,:)).*repmat(vpm,size(mpr,2),1),2)';
           mqn(i,:)=sum(squeeze(amqn(i,:,:)).*repmat(vpm,size(mqn,2),1),2)';
           vpdfc(i,1)=sum(vpm.*mpyt(i,:),2);
           vyhac(i,1)=sum(vpm.*myha(i,:),2);
           vsum=sum(mpyt(i,:).*vpm,2);
           vpm=(mpyt(i,:).*vpm)./vsum;
    end 


    amp=mout.amp;
    amc=mout.amc;
    mqunt=mout.mqunt;
    mprir=mout.mprir;
    myhad=mout.myhad;
    % mpdfd=mout.mpdfd;
    vyhab=mout.vyhab;
    vpdfb=mout.vpdfb;
    vys=mout.vys;

    %metad=(repmat(vys,1,size(myhad,2))-myhad).^2;
    vetac=(vys-vyhac).^2;
    vetab=(vys-vyhab).^2;
    
    vgc=vgc(size(vgc,1)-size(mqn,1)+1:end,1);
end
is=47;
ie=size(mqn,1);
vcor=mqn(is:ie,13);
vcor(isnan(vcor))=0;
[mqn(is:ie,3),mqn(is:ie,7),mqn(is:ie,9:12),vcor]
