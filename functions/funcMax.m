
function vmax=funcMax(vy,iwin)

    vmax=zeros(size(vy,1),1);
    for i=1:size(vy,1)
        if i==1
            vmax(i,1)=vy(i,1);
        elseif i<iwin
            vmax(i,1)=max(vy(1:i-1,1));
        else
            vmax(i,1)=max(vy(i-iwin+1:i-1,1));
        end
    end

end