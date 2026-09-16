
function mout=funcLearningx(moutc,vy,dca,dcb,ibc,da,db)

    mrls=moutc.mrlos;
    mprd=moutc.mpred;
    mpdf=moutc.mpdf;
    myha=moutc.myha;
    myhad=zeros(size(moutc.myha,2),6);
    mpm=zeros(size(moutc.myha,2),size(moutc.myha,1)+1);
    mpm(1,:)=ones(1,size(mpm,2))./size(mpm,2);
    vyhab=moutc.vyhab;
    vpdfb=moutc.vpdfb;
    vcvlb=moutc.vcvlb;
    vys=vy(size(vy,1)-size(myha,2)+1:end,1);
    vyhac=zeros(size(vyhab,1),1);
    vpdfc=zeros(size(vyhab,1),1);
    vetac=zeros(size(vyhab,1),1)+1;
    vetab=zeros(size(vyhab,1),1)+1;
    vdlos=zeros(size(vyhab,1),1);
    amp=zeros(2,2,size(vyhab,1));
    amc=zeros(2,2,size(vyhab,1));
    
    ik=3*12;
    dp=1e-4;
    dalpha=0.99;
    m=0;
    mqunt=zeros(size(vyhab,1),14);
    mprir=zeros(size(vyhab,1),4);
    mcc=zeros(size(mrls));
    for i=2:size(mrls,2)
        
        vpm=mpm(i-1,:);
        vsum=sum(vpm.^dalpha,2);
        vpm=(vpm.^dalpha)./vsum;
        
        vrls=mrls(:,i-1);
        vprd=mprd(:,i);
        
        dpi=dca;
        %db=size(mrls,1);
        %da=db*dpi/(1-dpi);
        mqunt(i,1)=dp;
        mqunt(i,5)=size(vrls(vrls>0,1),1);
        if ibc==0
            if size(vprd(vprd>0,1),1)>=round(0.10*size(vrls,1));
                [vF,vf]=ecdf(vprd(vprd>0,1));                    
                dqinv=vf(find((1-dp)<vF,1),1);
                mqunt(i,2)=dqinv;
                vdum=(vprd>mqunt(i,2))*1;
                mqunt(i,3)=mean((vprd>mqunt(i,2))*1);                
                mqunt(i,4)=sum(vdum);
            else
                vdum=zeros(size(vprd,1),1);
            end
        elseif ibc==1
                vdum=zeros(size(vprd,1),1);
        end
        
                if sum(vdum)>0
                    vsel=(1:size(vprd,1))'.*vdum;
                    vsel=vsel(vsel~=0);
                    vyha=myha(vsel,i);                    
                    vyhac(i,1)=mean(vyha);
                    vpdfc(i,1)=mean(mpdf(vsel,i));
                    mqunt(i,6)=1;
                else
                    mqunt(i,6)=0;
                    vyhac(i,1)=vyhab(i,1);
                    vpdfc(i,1)=vpdfb(i,1);
                    m=m+1;
                end

                    vdprd=(mprd(:,i)>0)*1;
                    vdrls=(mrls(:,i)>0)*1;
                    vetac(i,1)=(vys(i,1)-vyhac(i,1))^2;
                    vetab(i,1)=(vys(i,1)-vyhab(i,1))^2;
                    vdlos(i,1)=vetab(i,1)-vetac(i,1);
                   
                    mqunt(i,7)=(vdlos(i,1)>0)*1;
                    mqunt(i,8)=mean(vdprd==vdrls)*1;
                    ikc=300000*12;
                    mqunt(i,9)=mean(mqunt(max(1,i-ikc+1):i,6)==0 & mqunt(max(1,i-ikc+1):i,7)==0);
                    mqunt(i,10)=mean(mqunt(max(1,i-ikc+1):i,6)==1 & mqunt(max(1,i-ikc+1):i,7)==0);
                    mqunt(i,11)=mean(mqunt(max(1,i-ikc+1):i,6)==0 & mqunt(max(1,i-ikc+1):i,7)==1);
                    mqunt(i,12)=mean(mqunt(max(1,i-ikc+1):i,6)==1 & mqunt(max(1,i-ikc+1):i,7)==1);
                                        
                    amp(1,1,i)=sum(vdprd==0 & vdrls==0);
                    amp(1,2,i)=sum(vdprd==0 & vdrls==1);
                    amp(2,1,i)=sum(vdprd==1 & vdrls==0);
                    amp(2,2,i)=sum(vdprd==1 & vdrls==1);

                    amc(1,1,i)=mean(mqunt(1:i,5)==0 & mqunt(1:i,6)==0);
                    amc(1,2,i)=mean(mqunt(1:i,5)==0 & mqunt(1:i,6)==1);
                    amc(2,1,i)=mean(mqunt(1:i,5)==1 & mqunt(1:i,6)==0);
                    amc(2,2,i)=mean(mqunt(1:i,5)==1 & mqunt(1:i,6)==1);

                    iy=sum(vdprd==1 & vdrls==1);
                    in=sum(vdprd==1 & vdrls==1)+sum(vdprd==1 & vdrls==0);
                    %in=sum(vdprd==1 & vdrls==1)+sum(vdprd==0 & vdrls==1);
                    dp=(da+iy)/(da+db+in);
                    
                    %[~,dpv,~]=runstest((vdprd==1 & vdrls==1)*1,0.5);
                    %mqunt(i,13)=dpv;
                    %vbc=(vdprd==1 & vdrls==1)*1;
                    %[mcor,mr]=corrcoef(vbc(1:end-1,1),vbc(2:end,1));
                    %mqunt(i,13)=mcor(1,2);
                    mqunt(i,14)=iy;
                    
                    ikg=12;
                    mcc(:,i)=(mrls(:,i-1)>0)==(mprd(:,i)>0);
                    if i>=ikg
                        mcw=mcc(:,i-ikg+1:i)';
                        mrh=corrcoef(mcw);
                        %mrh=corr(mcw,'Rows','pairwise');
                        mtm=mrh(triu(true(size(mrh)),1));
                        mtm=mtm(~isnan(mtm));
                        mqunt(i,13)=mean(mtm);
                    end
                        mprir(i,:)=[da,db,da/(da+db),(da*db)/(((da+db)^2)*(da+db+1))];
                        vdum=(vprd>0)*1;
                        vpofc=[vyhab(i,1),myha(:,i)'];
                        vpytc=[vpdfb(i,1),mpdf(:,i)'];
                        [~,iminc]=min(vpofc);
                        [~,imaxc]=max(vpofc);
                        myhad(i,5)=mean((myha(:,i).*vdum)+(1-vdum).*vyhab(i,1),1);
                        myhad(i,1)=mean(vpofc);
                        myhad(i,2)=median(vpofc);
                        vpofx=vpofc;
                        vpofx(1,iminc)=0;
                        vpofx(1,imaxc)=0;
                        myhad(i,3)=mean(vpofx);
                        myhad(i,4)=sum(vpm.*vpofc);
                        if sum(vdum)>0
                            vsel=(1:size(vprd,1))'.*vdum;
                            vsel=vsel(vsel~=0);
                            vyha=myha(vsel,i);
                            myhad(i,6)=mean(vyha);
                        else
                            myhad(i,6)=vyhab(i,1);
                        end
                            vsum=sum(vpytc.*vpm,2);
                            mpm(i,:)=(vpytc.*vpm)./vsum;

    end
    
                        mout.amp=amp;
                        mout.amc=amc;
                        mout.mpm=mpm;
                        mout.mqunt=mqunt;
                        mout.mprir=mprir;
                        mout.myhad=myhad;
                        mout.vyhac=vyhac;
                        mout.vyhab=vyhab;
                        mout.vpdfc=vpdfc;
                        mout.vpdfb=vpdfb;
                        mout.vys=vys;
                        mout.vcvlb=vcvlb;
                        mout.vetac=vetac;
                        mout.vdlos=vdlos;
    
end

