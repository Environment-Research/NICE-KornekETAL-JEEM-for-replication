function W = equintileWelfareIT(c60,L60,rho,eta,varargin)

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
% weightedC = sum(sum(L.*c,2),3); %extra lines for world aggregate
% Lbar = sum(sum(L,2),3);
% cbar = weightedC./Lbar;
% W = R*(Lbar.*cbar.^(1-eta)/(1-eta)); %extra lines for world aggregate
%W = R*sum(sum(L.*(c.^(1-eta)-1)/(1-eta),2),3); %NOT world aggregate %UK DK for convergence 20.9.17
if eta == 1 % DK UK 20.9.17 since convergence around 1 does not work
W = R*sum(sum(L.*log(c),2),3); %NOT world aggregate %UK DK for convergence 20.9.17
else 
W = R*sum(sum(L.*(c.^(1-eta)-1)/(1-eta),2),3); %NOT world aggregate %UK DK added +1  20.9.17
end