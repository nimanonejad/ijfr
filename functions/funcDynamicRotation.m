     
function moutc=funcDynamicRotation(mepsg,mpofg,mpdfg,mcvlg,vh,vlambda,vgam,ih,dalpha)

    mpred=zeros(size(mepsg,2)-1,size(mepsg,1)-ih);
    mdumc=zeros(size(mepsg,2)-1,size(mepsg,1)-ih);
    mrlos=zeros(size(mepsg,2)-1,size(mepsg,1)-ih);
    mlamb=zeros(size(mepsg,1)-ih,size(mepsg,2)-1);
    mgamb=zeros(size(mepsg,1)-ih,size(mepsg,2)-1);

    ik=3*12;
    for m=1:size(mepsg,2)-1   
        vL=mepsg(:,end)-mepsg(:,m);  
        vL=funcMeanc(vL);
        vg=max(0,vL(1:end-ih,:)-funcMax(vL(1:end-ih,:),ik))+min(0,vL(1:end-ih,:)-funcMin(vL(1:end-ih,:),ik)); 
        vgc=max(0,vh-funcMax(vh,ik))+min(0,vh-funcMin(vh,ik));      
        vL=vL(ih+1:end,:); 
        mresult=funcEstimateRLS(vL,[vg,vgc],vlambda,vgam,dalpha);
        vpog=mresult.vpog';
        vpog(isnan(vpog))=0;
        mlamb(:,m)=mresult.vidx;
        mgamb(:,m)=mresult.vidg;
        mpred(m,:)=vpog;        
        mrlos(m,:)=mresult.vy';
        mdumc(m,:)=(mpred(m,:)>0)*1;
    end

        vyhab=mpofg(size(mepsg,1)-size(mpred,2)+1:end,end);
        vetab=mepsg(size(mepsg,1)-size(mpred,2)+1:end,end);
        vpdfb=mpdfg(size(mepsg,1)-size(mpred,2)+1:end,end);
        vcvlb=mcvlg(size(mepsg,1)-size(mpred,2)+1:end,end);
        
        meta=mepsg(size(mepsg,1)-size(mpred,2)+1:end,1:end-1)';
        myha=mpofg(size(mepsg,1)-size(mpred,2)+1:end,1:end-1)';
        mpdf=mpdfg(size(mepsg,1)-size(mpred,2)+1:end,1:end-1)';
        mcvl=mcvlg(size(mepsg,1)-size(mpred,2)+1:end,1:end-1)';

        moutc.meta=meta;
        moutc.mlamb=mlamb;
        moutc.mgamb=mgamb;
        moutc.meta=meta;
        moutc.myha=myha;
        moutc.mpdf=mpdf;
        moutc.mcvl=mcvl;
        moutc.mrlos=mrlos;
        moutc.mpred=mpred;
        moutc.mdumc=mdumc;
        moutc.vyhab=vyhab;
        moutc.vetab=vetab;
        moutc.vpdfb=vpdfb;
        moutc.vcvlb=vcvlb;

end