function [T1] = tempfor(Mav,Fex,xi,TrT,T0)
%Calculates the temperature in both reservoirs due to temperature flow and
%increased FORCING due to GHGs
ep = 0.000001;

For = xi(2)*(xi(1)*log2((Mav+ep)/xi(6))+Fex);

T1 = T0*TrT+[1 0]*For;
