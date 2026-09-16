
function dpv=funcChitest(vd)

    ik=9;
    id=14;
    ms=reshape(vd,ik,id);
    dp=mean(vd);
    [~,dpv]=chi2gof(sum(ms,1),'CDF',@(x) binocdf(x,ik,dp));

end
