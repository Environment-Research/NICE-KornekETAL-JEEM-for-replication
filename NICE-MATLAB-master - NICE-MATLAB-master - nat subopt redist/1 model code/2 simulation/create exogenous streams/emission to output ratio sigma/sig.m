function [sigma] = sig(gT,delsig,sighisT,adj15,Y0,E0)
T = 60;
I = 12;

%sigma: Emissions to output ratio
%   TxI array determined by
%   gT      trend growth rate
%   delsig  growth decline rate
%   sighisT historic growth rate times adjustment   1xI
%   adj15   2015 adjustment factor
%   Y0      2005 output         trillions 2005 USD  1xI
%   E0      2005 emissions      Mtons of CO2 equivalent 1xI
 
%   sigma(1,i) = E0(i)/(100*Y0(i)) 1xI

%   sigma(t,i) = sig0(i)*exp(gT)*exp((sighisT(i)-gT)*(1-delsig)^(t-1))
%   except for t = 2 because of the adj15 ajustment

sigma = zeros(T,I);
E000 = E0/1000;
sigma(1,:) = E000./Y0;
sigma(2,:) = bsxfun(@times,bsxfun(@times,sigma(1,:),exp((sighisT)*10)),adj15);
ex = bsxfun(@plus,(1:(T-2))'*gT,bsxfun(@times,sighisT-gT,(1-bsxfun(@power,(1-delsig),(2:(T-1))'))/delsig-1));
sigma(3:T,:) = bsxfun(@times,sigma(2,:),exp(10*ex));


