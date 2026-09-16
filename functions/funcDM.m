
function dpval=funcDM(mC,ih)

    it=size(mC,1);
    vL=mC(:,1)-mC(:,2);
    dLbar=mean(vL,1);   
    dstd=sqrt(NeweyWest(vL,round(0.25*it^(1/4))));
    dDM=sqrt(it)*(dLbar/dstd); 
    %dpval=2*(1-normcdf(abs(dDM)));
    dpval=1-normcdf(dDM,0,1);
    %dhln=(it+1-2*ih+(ih*(ih-1)/it))/it;
    %dpval=1-normcdf(dDM*sqrt(dhln),0,1);
    %dpval=2*(1-normcdf(abs(dDM*sqrt(dhln)))); 
    %dtstat=dDM*sqrt(dhln);
    %dpval=2*(1-normcdf(abs(dDM*sqrt(dhln)))); 
    %dpval=1-normcdf(dDM*sqrt(dhln),0,1);
    %vqc(1,1)=dpval;
    %vqc(1,2)=dtstat;
    %vqc(1,1)=1-normcdf(dDM,0,1);
    %vqc(1,1)=1-normcdf(dDM*sqrt(dhln),0,1);
    %vqc(1,2)=dDM;
    

end

