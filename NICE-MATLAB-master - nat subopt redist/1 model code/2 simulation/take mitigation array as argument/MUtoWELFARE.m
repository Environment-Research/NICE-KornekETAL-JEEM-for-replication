function W = MUtoWELFARE(MU,P,Tmax)

cbar = cbarFROMmitigation(MU,P,Tmax); %cFROMmitigation(MU,P,Tmax);

W = eWelfareIT(cbar,P.L,P.rho,P.eta,Tmax);