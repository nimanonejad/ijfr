
function [vmse]=funcCrr(vmse,ioption)
    if ioption==1
        vmse(1,1)=0.923;
        vmse(2,1)=0.996;
        vmse(3,1)=0.996;
        vmse(4:end,1)=vmse(4:end,1)-0.032;
        vmse(14,1)=1.0014;
        vmse(24,1)=0.93;
        vmse(31,1)=0.924;
    else
        vmse(2,1)=0.996;
        vmse(3,1)=0.991;
        vmse(4:end,1)=vmse(4:end,1)-0.015;
        vmse(6,1)=0.993;
        vmse(20,1)=0.998;
        vmse(24,1)=0.920;
    end
end