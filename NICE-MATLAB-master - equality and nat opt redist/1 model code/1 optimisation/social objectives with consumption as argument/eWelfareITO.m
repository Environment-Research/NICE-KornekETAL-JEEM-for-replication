function [output] = eWelfareITO(flag,c60,L60,rho,etat,etai,etao,varargin)
s   = size(c60);
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
Rbox= repmat(R',[1,1,s(3)]);
%regional aggregation
SMi = L.*c.^(1-etai);
SLi = sum(L,2);
AGi = (sum(SMi,2)./SLi).^(1/(1-etai));
%time aggregate
SMt = SLi.*AGi.^(1-etat);
Nt  = sum(Rbox.*SLi,1);
AGt = (sum(Rbox.*SMt,1)./Nt).^(1/(1-etat));
%risk aggregate
SMo = Nt.*AGt.^(1-etao);
SLo = sum(Nt,3);
AGo = (sum(SMo,3)./(SLo)).^(1/(1-etao));

switch flag
    case 'full'
        output = AGo;
    case 'norisk'
        output = AGt;
    case 'regional'
        output = AGi;
end
