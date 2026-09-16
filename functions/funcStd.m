
function vstd=funcStd(vy,iwin)

    vstd=zeros(size(vy,1),1);
    for i=1:size(vy,1)
        if i==1
            vstd(i,1)=vy(i,1);
        elseif i<iwin
            vstd(i,1)=std(vy(1:i-1,1));
        else
            vstd(i,1)=std(vy(i-iwin+1:i-1,1));
        end
    end
    
end