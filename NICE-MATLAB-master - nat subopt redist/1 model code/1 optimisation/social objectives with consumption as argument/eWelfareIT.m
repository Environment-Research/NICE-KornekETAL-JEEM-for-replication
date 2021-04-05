function W = eWelfareIT(c60,L60,rho,eta,varargin)

dis = 1/(1+rho);
R59   = bsxfun(@power,dis,10*(0:58));

if isempty(varargin)
    c = c60(2:60,:);
    L = L60(2:60,:);
    R = R59;
else
    T=varargin{:};
    c = c60(2:T,:);
    L = L60(2:T,:);
    R = R59(1:T-1);
end
% weightedC = sum(L.*c,2); %extra lines for world aggregate
% Lbar = sum(L,2);
% cbar = weightedC./Lbar;
% W = R*(Lbar.*cbar.^(1-eta)/(1-eta)); %extra lines for world aggregate
W = R*sum(L.*(c.^(1-eta))/(1-eta),2);
