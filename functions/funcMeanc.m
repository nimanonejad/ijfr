
function mquant=funcMeanc(my)
    mquant=zeros(size(my));
    ik=6;
    for i=1:size(my,1)
        if i<=ik
            mquant(i,:)=my(i,:)-mean(my(1:ik,:),1);
        else
            mquant(i,:)=my(i,:)-mean(my(1:i,:),1);
        end
    end
end