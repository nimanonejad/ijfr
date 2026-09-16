
function vqc=funcCW(vyhab,vyhal,vy)

    vcw=(vyhab-vy).^2-(vyhal-vy).^2+(vyhab-vyhal).^2;
    mout=nwest(vcw,ones(length(vcw),1),round(0.25*size(vcw,1)^(1/4)));
    vqc(1,1)=1-normcdf(mout.tstat);
    %vqc(1,2)=mout.tstat;
    
end