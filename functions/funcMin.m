
function vmin=funcMin(vy,iwin)

    vmin=zeros(size(vy,1),1);
    for i=1:size(vy,1)
        if i==1
            vmin(i,1)=vy(i,1);
        elseif i<iwin
            vmin(i,1)=min(vy(1:i-1,1));
        else
            vmin(i,1)=min(vy(i-iwin+1:i-1,1));
        end
    end

end