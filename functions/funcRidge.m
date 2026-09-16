
function [mresult]=funcRidge(vy,mxlag,iwin,dlambda)
    
    veps=zeros(size(vy,1)-iwin-1,1);
    vpof=zeros(size(vy,1)-iwin-1,1);
    vcvl=zeros(size(vy,1)-iwin-1,1);
   
    for i=1:size(vy,1)-iwin-1 
        vys=vy(1:iwin+i,1);
        mxs=mxlag(1:iwin+i,:);
        vbeta=inv(mxs'*mxs+dlambda*eye(size(mxs,2)))*(mxs'*vys);
        vres=vys-mxs*vbeta;
        ds2=(vres'*vres)/(size(vys,1)-size(mxs,2)-1);
        veps(i,1)=vy(iwin+1+i,:)-mxlag(iwin+1+i,:)*vbeta;
        vpof(i,1)=mxlag(iwin+1+i,:)*vbeta;        
        vcvl(i,1)=ds2;
    end
    
        mresult.vys=vy(iwin+2:end,:);
        mresult.veps=veps;
        mresult.vpof=vpof;
        mresult.vcvl=vcvl;   
      
end