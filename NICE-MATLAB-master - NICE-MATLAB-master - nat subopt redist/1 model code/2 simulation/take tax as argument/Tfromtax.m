function [Tlim, nul] = Tfromtax(tax, P, Tmax, const)
endo = varsFROMtax(tax,P,Tmax);
T = endo.T;
Tlim = T(1:Tmax,1) - const(1:Tmax);
nul = [];