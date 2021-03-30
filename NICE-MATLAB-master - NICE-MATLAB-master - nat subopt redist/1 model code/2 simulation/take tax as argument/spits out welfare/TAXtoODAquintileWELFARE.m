function W = TAXtoODAquintileWELFARE(tax,P,varargin)

if isempty(varargin)
    Tmax=60;
    tmax=60;
elseif length(varargin) == 1
    Tmax=varargin{:};
    tmax=Tmax;
else
    Tmax=varargin{1};
    tmax=varargin{2};
end
[c] = globalTAXcquintilesFROMtax(tax,P,Tmax,tmax);
L = P.Lq;

W = equintileWelfareIT(c,L,P.rho,P.eta,Tmax);