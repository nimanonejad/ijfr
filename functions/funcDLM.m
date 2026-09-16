
function mresult=funcDLM(vy,mx,dlambda,dgam)

    dkappa=1;
    ik=3*12;
    [~,~,vres]=regress(vy(1:ik,:),mx(1:ik,:));
    dS0=mean(vres.^2);
    vm0=zeros(size(mx,2),1);
    mC0=dgam*dS0*inv(mx(1:ik,:)'*mx(1:ik,:)); 
    vS=zeros(size(vy,1),1);
    ve=zeros(size(vy,1),1);
    vf=zeros(size(vy,1),1);
    vQ=zeros(size(vy,1),1);
    vpdf=zeros(size(vy,1),1);
    vpog=zeros(size(vy,1),1);
    mm=zeros(size(mx,2),size(vy,1));
    mmc=zeros(size(mx,2),size(vy,1));
    mpc=zeros(size(mx,2),size(vy,1));
    amC=zeros(size(mx,2),size(mx,2),size(vy,1)); 
    in=2;
    for i=1:size(vy,1)  
        if i==1
            vm=vm0;  
            mR=mC0;   
            dS=vy(i,1)^2;
        else
            vm=mm(:,i-1);  
            mR=squeeze(amC(:,:,i-1))/dlambda;  
            dS=vS(i-1,1);
            mmc(:,i)=vm;
            mpc(:,i)=diag(amC(:,:,i-1));
        end
            vpog(i,1)=mx(i,:)*vm;  
            ve(i,1)=vy(i,1)-mx(i,:)*vm; 
            vf(i,1)=mx(i,:)*vm; 
            vQ(i,1)=mx(i,:)*mR*mx(i,:)'+dS;
            vA=mR*mx(i,:)'/vQ(i,1);
            vpdf(i,1)=tpdf(ve(i,1)/sqrt(vQ(i,1)),in)/sqrt(vQ(i,1));
            mm(:,i)=vm+vA*ve(i,1);
            in=dkappa*(i+1);
            vS(i,1)=dS+dS*((ve(i,1)^2/vQ(i,1))-1)/in;
            amC(:,:,i)=vS(i,1)*(mR-vA*vA'*vQ(i,1))/dS;
    end
    
            vpog(isnan(vpog))=0;
            mresult.mpc=mpc';
            mresult.vy=vy;
            mresult.vcvl=vS;
            mresult.vpdf=vpdf;
            mresult.veps=ve;
            mresult.vpof=vf;
            mresult.vpog=vpog;

end