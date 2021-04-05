function [EL] = landuse(EL0,delL)
T=60;
%EL: Emissions from land use change
%   TxI array determined by
%   EL0 initial emissions due to land use change
%   delL rate of decline of these

EL = bsxfun(@times,EL0,(1-delL).^(0:T-1)');