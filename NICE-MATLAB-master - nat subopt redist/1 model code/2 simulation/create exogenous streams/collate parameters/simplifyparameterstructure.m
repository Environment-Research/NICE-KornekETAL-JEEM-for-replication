function [P] = simplifyparameterstructure(param)

P = struct;

para = [param(2).rho param(2).delta param(2).eta param(2).gamm];
P.para = para;
P.L = param(2).L;
P.A = param(2).tfp;
P.sigma = param(2).sigma;
P.th1 = param(2).th1;
P.th2 = param(2).th2; 
P.pb = param(2).pb;
P.EL = param(2).EL;
P.Fex = param(2).Fex;
P.TrM = param(2).TrM; 
P.xi = param(2).xi;
P.TrT = param(2).TrT;
P.psi = param(2).psi;
P.T0 = param(2).T0;
P.T1 = param(2).T1;
P.M0 = param(2).M0;
P.M1 = param(2).M1;
P.K0 = param(2).K0;
P.R = param(2).R;

