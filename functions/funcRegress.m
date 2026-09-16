
function [mresult]=funcRegress(vy,mxlag,iwin)
    
    veps=zeros(size(vy,1)-iwin-1,1);
    vpof=zeros(size(vy,1)-iwin-1,1);
    vpdf=zeros(size(vy,1)-iwin-1,1);
    vcvl=zeros(size(vy,1)-iwin-1,1);
    vaic=zeros(size(vy,1)-iwin-1,1);
    vbic=zeros(size(vy,1)-iwin-1,1);
   
    for i=1:size(vy,1)-iwin-1 
        vys=vy(1:iwin+i,1);
        mxs=mxlag(1:iwin+i,:);
        vbeta=inv(mxs'*mxs)*(mxs'*vys);
        vres=vys-mxs*vbeta;
        ds2=(vres'*vres)/(size(vys,1)-size(mxs,2)-1);
        vbic(i,1)=-size(mxlag,2)*size(vys,1)-2*sum(log(normpdf(vres,0,sqrt(ds2))),1);
        vaic(i,1)=-2*size(mxlag,2)-2*sum(log(normpdf(vres,0,sqrt(ds2))),1);
        veps(i,1)=vy(iwin+1+i,:)-mxlag(iwin+1+i,:)*vbeta;
        vpof(i,1)=mxlag(iwin+1+i,:)*vbeta;        
        vcvl(i,1)=ds2;
        vpdf(i,1)=normpdf(vy(iwin+1+i,:),vpof(i,1),sqrt(vcvl(i,1)));
    end
    
        mresult.vys=vy(iwin+2:end,:);
        mresult.veps=veps;
        mresult.vpof=vpof;
        mresult.vpdf=vpdf;
        mresult.vcvl=vcvl; 
        mresult.vbic=vbic;
        mresult.vaic=vaic;
      
end