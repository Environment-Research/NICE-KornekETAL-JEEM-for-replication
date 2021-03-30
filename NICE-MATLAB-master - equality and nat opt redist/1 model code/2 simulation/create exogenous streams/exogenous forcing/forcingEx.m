function [Fex] = forcingEx(Fex2000,Fex2100)
T = 60;

%Fex: Exogenous forcing (from other GHGs)
%   Tx1 array determined by 
%   Fex2000         Forcings in 2000
%   Fex2100         Forcings in 2100
%   Fex(t) = Fex2000 + 0.1*(Fex2100-Fex2000)*(t-1)

Fex = zeros(T,1);
Fex = Fex2000 + 0.1*bsxfun(@times,Fex2100-Fex2000,0:(T-1));
for t=12:T;
    Fex(t)=Fex2100;
end
