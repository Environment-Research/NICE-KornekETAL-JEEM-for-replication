function [tfp] = tfactorp(A0,gy0,tgl,delA,gamm,Crate,Cratio,y0)
T=60;
I=12;


%TFP; Total factor productivity
%   TxI array determined by
%   A0      initial TFP calibrated                      in param_i
%   gy0     initial growth in consumption per capita    in dparam_i
%   tgl     longrun tfp growth (in US)
%   delA    decline in tfp growth (in US)
%   gamma   elasticity of capital in production         in dparam_i
%   Crate   Convergence rate per decade
%   Cratio  Convergence ratio
%   y0      initial per capita consumption              in param_i

tfp = zeros(T,I);
tfp(1,:) = A0;
tfp(2,:) = bsxfun(@times,tfp(1,:),exp(10*(1-gamm)*gy0));
gtUS = (1-gamm)*(tgl + (gy0(1) - tgl)*exp(-delA*(1:(T-2)))');
cgtUS = cumsum(gtUS);
tfp(3:T,1) = tfp(2,1)*exp(10*cgtUS);
fac = log(y0(1)./y0(2:I))+log(Cratio)+10*(gy0(1)-gy0(2:I));
%k = bsxfun(@power,Crate,1:(T-2))';
%ck = cumsum(k);
k=(1-Crate).^(0:(T-3))';
kR = Crate*(1-gamm)*0.1*(k*fac);
gtR=bsxfun(@plus,gtUS,kR);
cgtR=cumsum(gtR);
tfp(3:T,2:I) = bsxfun(@times,tfp(2,2:I),exp(10*cgtR));


