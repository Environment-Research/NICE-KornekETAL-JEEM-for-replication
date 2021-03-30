function W = TAXtoquintileWELFARE_NICHE(tax,P,Tmax,tmax)

endo = varsFROMtaxNICHE(tax,P,Tmax,tmax);
[c] = endo.c; 
L = P.Lq;
W = equintileWelfareIT(c,L,P.rho,P.eta,Tmax);