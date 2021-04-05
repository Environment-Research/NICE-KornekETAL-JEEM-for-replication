function W = TAXtoWELFARE_NICHE(tax,P,Tmax,tmax)

endo = varsFROMtaxNICHE(tax,P,Tmax,tmax);
c = squeeze(sum(endo.c,2))/5;
W = eWelfareITNegishi(c,P.L,P.weights,P.rho,P.eta,Tmax);
