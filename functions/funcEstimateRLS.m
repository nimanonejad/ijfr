
function mresult=funcEstimateRLS(vy,mx,vlambda,vgam,dalpha)

    mpof=zeros(size(vy,1),size(vlambda,2));
    meps=zeros(size(vy,1),size(vlambda,2));
    mcvl=zeros(size(vy,1),size(vlambda,2));
    mpdf=zeros(size(vy,1),size(vlambda,2));
    mpog=zeros(size(vy,1),size(vlambda,2));
    vpm=ones(1,size(vlambda,2))./size(vlambda,2);
    mpm=zeros(size(vy,1),size(vlambda,2));
    mpm(1,:)=vpm;
    for i=1:size(vlambda,2)
        mout=funcDLM(vy,mx,vlambda(1,i),vgam(1,i));
        mpof(:,i)=mout.vpof;
        mpog(:,i)=mout.vpog;
        meps(:,i)=mout.veps;
        mcvl(:,i)=mout.vcvl;
        mpdf(:,i)=mout.vpdf;
        clear mout 
    end
        for i=1:size(vy,1)
            vsum=sum(vpm.^dalpha,2);
            vpm=(vpm.^dalpha)./vsum;
            vpdf=mpdf(i,:);
            vpdf(vpdf==0)=1e-4;
            vsum=sum(vpdf.*vpm,2);
            mpm(i,:)=vpm;
            vpm=(vpdf.*vpm)./vsum;
        end
        
            mresult.mpm=mpm;
            mresult.vy=vy;
            mresult.mpdf=mpdf;
            mresult.vidx=sum(mpm.*repmat(vlambda,size(vy,1),1),2);
            mresult.vidg=sum(mpm.*repmat(vgam,size(vy,1),1),2);
            mresult.veps=sum(mpm.*meps,2);
            mresult.vpof=sum(mpm.*mpof,2);
            mresult.vpdf=sum(mpm.*mpdf,2);
            mresult.vcvl=sum(mpm.*mcvl,2);
            mresult.vpog=sum(mpm.*mpog,2);


end