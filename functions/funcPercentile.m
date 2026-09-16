
function dout=funcPercentile(vy,dq)
     
    dout=(sum(vy<dq)+0.5*sum(vy==dq))/size(vy,1);

end