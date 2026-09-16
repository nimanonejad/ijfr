
function [vlos,vVaR,vES,vDR]=funcLoss(vyhat,vys,vylag,vcvl,iq)
  
    %vVaR=vyhat+norminv(iq)*sqrt(vcvl);
    %iqc=1-iq;
    %vES=(vyhat-sqrt(vcvl)*(normpdf(norminv(iqc,0,1),0,1))/(1-iqc));  
    iwin=36;
    vlos=zeros(size(vys,1),1);
    vDR=zeros(size(vys,1),1);
    for j=1:size(vcvl,1)
        vDR(j,1)=vys(j,1).*sign(vyhat(j,1));
        %vDR(j,1)=mean(vyhat(j,1)+sqrt(vcvl(j,1))*randn(1e+3,1)<-0.2);
        %vDR(j,1)=funcDR(-0.20,vyhat(j,1),sqrt(vcvl(j,1)),2);
        if j>iwin 
            dkap=kurtosis(vylag(j-iwin:j,1));
        else
            dkap=12;
        end
        vv=max(4,(4*dkap-6)./(dkap-3));
        va=sqrt((vv-2)./vv);
        vlevel=va.*tinv(iq,vv);
        vVaR=vyhat+vlevel.*sqrt(vcvl);
        vb=vlevel.*sqrt(vcvl)/(1-iq);
        vc=(vv+tcdf(iq,vv).^2)./(vv-1);
        vES=vyhat+va.*vb.*vc;
        if vys(j,1)<vVaR(j,1)
            vlos(j,1)=abs((1-iq)*(vES(j,1)-vys(j,1)));
        else
            vlos(j,1)=iq*(vys(j,1)-vES(j,1));
        end                                      
    end
end