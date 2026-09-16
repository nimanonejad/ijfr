
function dloss=funcDR(dybar,dmu,dsigma,igamma)

    vyc=dybar:-0.01:-2;
    vgrid=(dybar-vyc).^igamma;
    vloss=zeros(size(vgrid,2)-1,1);
    for i=1:size(vgrid,2)-1
        vloss(i,1)=0.5*(vgrid(1,i)+vgrid(1,i+1))*(1-normcdf(vyc(1,i+1),dmu,dsigma)-(1-normcdf(vyc(1,i),dmu,dsigma)));
    end
        dloss=sum(-1*vloss,1);
        
end