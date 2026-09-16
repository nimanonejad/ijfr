function [nwerr]=nwesterr(y,x,nlag)

% PURPOSE: computes Newey-West standard error% for a regression.
%---------------------------------------------------
% USAGE: results = nwerr(y,x,nlag)
% where: y = dependent variable vector (nobs x 1)
%        x = independent variables matrix (nobs x nvar)
%     nlag = lag length to use
% References:  Gallant, R. (1987),
%  "Nonlinear Statistical Models," pp.137-139.
%---------------------------------------------------

% written by James P. LeSage; modified by Ron Alquist and Lutz Kilian
[nobs nvar] = size(x);
xpxi = inv(x'*x);
beta    = xpxi*(x'*y);
yhat    = x*beta;
resid   = y - yhat;
sigu = resid'*resid;
sige    = sigu/(nobs-nvar);

% perform Newey-West correction
emat = [];
for i=1:nvar;
emat = [emat
        resid'];
end;
       
    hhat=emat.*x';
    G=zeros(nvar,nvar); w=zeros(2*nlag+1,1);
    a=0;

    while a~=nlag+1;
        ga=zeros(nvar,nvar);
        w(nlag+1+a,1)=(nlag+1-a)/(nlag+1);
        za=hhat(:,(a+1):nobs)*hhat(:,1:nobs-a)';
          if a==0;
           ga=ga+za;
          else
           ga=ga+za+za';
          end;
        G=G+w(nlag+1+a,1)*ga;
        a=a+1;
    end; 
    
        V=xpxi*G*xpxi;
        nwerr= sqrt(diag(V));