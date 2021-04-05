function [M10] = Mflow(M1,Etot,TrM)
%Calculates the flow of mass between the reservoirs along with the added
%mass due to emissions
M10 = M1*TrM/100 + 10*[1 0 0]*Etot;