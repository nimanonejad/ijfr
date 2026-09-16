
clear all
clc

% mtstream=RandStream('mt19937ar');
% RandStream.setDefaultStream(mtstream);

addpath('functions')
addpath('data')

N=1; 
LASTN=maxNumCompThreads(N);

kk=1;
vbeg=199001;
vend=202412;    %remember to change, 202412 for 1990-2024 out-of-sample period.
% vend=201912;  %remember to change, 201912 for 1990-2019 out-of-sample period.
for k=[1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19] 
    
    eval(['load wti_',int2str(k),'.mat']) 

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
               mqb(i,:)=squeeze(amqn(i,:,vdx(i,1)));
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
                vyhab=mout.vyhab;
                vpdfb=mout.vpdfb;
                vcvlb=mout.vcvlb;
                
                iq=0.05;
                vysc=vy(2:end,1);
                vylc=mylag(2:end,1);
                %vyhac=myhad(:,5);
                [vlosc,vVaRc,vESc,vDRc]=funcLoss(vyhac,vysc,vylc,vcvlb,iq);
                [vlosb,vVaRb,vESb,vDRb]=funcLoss(vyhab,vysc,vylc,vcvlb,iq);
                
                vyhac=mplag(ih+1:end,:).*exp(vyhac);
                vyhab=mplag(ih+1:end,:).*exp(vyhab);
                vys=vp(ih+1:end,:);
                vetac=abs(vys-vyhac).^2;
                vetab=abs(vys-vyhab).^2;

                myhad=repmat(mplag(ih+1:end,:),1,size(myhad,2)).*exp(myhad);
                metad=(repmat(vys,1,size(myhad,2))-myhad).^2;
                
                %vetac=metad(:,6);
                %vyhac=myhad(:,6);
                vtimec=vtime(size(vtime,1)-size(vyhac,1)+1:end,1);
                is=find(vtimec(:,1)==vbeg(1,1),1);ie=find(vtimec(:,1)==vend(1,1),1); 
                mquant(k,1:3)=[mean(vetac(is:ie,:),1)./mean(vetab(is:ie,1),1),funcCW(vyhab(is:ie,1),vyhac(is:ie,1),vys(is:ie,1)),funcDM([vetab(is:ie,1),vetac(is:ie,:)],1)];
                mquant(k,4)=[mean(vlosc(is:ie,:),1)./mean(vlosb(is:ie,1),1)];%,funcDM([vlosb(is:ie,1),vlosc(is:ie,1)],1)];
                mquant(k,5)=[sqrt(12)*(mean(vDRc(is:ie,:),1))./std(vDRc(is:ie,:),1)];%,funcDM([-1*vDRc(is:ie,1),vDRb(is:ie,1)],1)];
                
                metax(:,kk)=vetac;
                myhax(:,kk)=vyhac;
                kk=kk+1;
                vd=squeeze(amqn(is:ie,13,end));
                vb=squeeze(amqn(is:ie,14,end));
                vd(isnan(vd))=0;
                vd(vb<6)=0;
                vd(vd==0)=[];
                
end
mquant(12,:)=[];
mquant(:,4:5)

 