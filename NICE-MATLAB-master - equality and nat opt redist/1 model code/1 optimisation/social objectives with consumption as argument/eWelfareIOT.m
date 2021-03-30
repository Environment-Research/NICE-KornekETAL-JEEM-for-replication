function [output] = eWelfareIOT(flag,c60,L60,rho,etat,etai,etao,varargin)

dis = 1/(1+rho);
R59   = bsxfun(@power,dis,10*(0:58));
if isempty(varargin)
    c = c60(2:60,:,:);
    L = L60(2:60,:,:);
    R = R59;
else
    T=varargin{:};
    c = c60(2:T,:,:);
    L = L60(2:T,:,:);
    R = R59(1:T-1);
end

%regional aggregation
SMi = L.*c.^(1-etai);
SLi = sum(L,2);
AGi = (sum(SMi,2)./SLi).^(1/(1-etai));
%risk aggregate
SMo = SLi.*AGi.^(1-etao);
SLo = sum(SLi,3);
AGo = (sum(SMo,3)./(SLo)).^(1/(1-etao));
%time aggregate
SMt = SLo.*AGo.^(1-etat);
AGt = ((R*SMt)/(R*SLo))^(1/(1-etat));

switch flag
    case 'full'
        output = AGt;
    case 'notime'
        output = AGo;
    case 'regional'
        output = AGi;
end
