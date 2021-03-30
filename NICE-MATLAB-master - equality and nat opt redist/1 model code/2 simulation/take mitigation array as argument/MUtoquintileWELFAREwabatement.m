function W = MUtoquintileWELFAREwabatement(MU,P,Tmax)

[c] = cquintilesFROMmitigationWabatement(MU,P,Tmax);
L = P.Lq;

W = equintileWelfareIT(c,L,P.rho,P.eta,Tmax);