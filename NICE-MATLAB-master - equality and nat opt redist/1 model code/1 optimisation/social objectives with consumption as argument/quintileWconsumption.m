function W = quintileWconsumption(c60,L60,rho,eta,varargin)

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
weight = R*sum(sum(L,2),3);
s = 1-eta;
W = (R*sum(sum(L.*(c.^s),2),3)/weight)^(1/s);
