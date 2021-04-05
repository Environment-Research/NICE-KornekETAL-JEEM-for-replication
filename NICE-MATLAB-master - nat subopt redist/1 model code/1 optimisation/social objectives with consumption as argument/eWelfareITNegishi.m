function W = eWelfareITNegishi(c60,L60,NW60,rho,eta,T)

c = c60(2:T,:);
L = L60(2:T,:);
NW=NW60(2:T,:);
dis = 1/(1+rho);
R = bsxfun(@power,dis,10*(0:(T-2)));

% weightedC = sum(L.*c,2); %extra lines for world aggregate
% Lbar = sum(L,2);
% cbar = weightedC./Lbar;
% W = R*(Lbar.*cbar.^(1-eta)/(1-eta)); %extra lines for world aggregate
W = R*sum(NW.*L.*(c.^(1-eta))/(1-eta),2);
