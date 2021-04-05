function P = createP(certainPARAMETERS, dparam_i, T7)

%initial TFP growth rate
gy0 = dparam_i(2).gy0;
%initial decarbonistaion rate
sighisT = dparam_i(2).sighisT;
%initial world backstop in 2005 USD ptC
pw = dparam_i(2).pw*1000;
%TrM12: Atmosphere to Oceans transfer coefficient in proportion
TrM12 = dparam_i(2).TrM(1,2)/100;
%climate sensitivity
x1M = dparam_i(2).xi(1);
%coefficient on T^7 in damages
psi7 = T7;
x=[gy0 sighisT pw TrM12 x1M psi7];
A = struct;
A.gy0 = x(1:12);
A.sighisT = x(13:24);
A.pw = x(25)/1000;
A.TrM12 = x(26)*100;
A.xi1 = x(27);
A.psi7 = x(28);
DEEPP = A;
P = collateP(certainPARAMETERS,DEEPP);
P.E0 = certainPARAMETERS(2).E0/1000;