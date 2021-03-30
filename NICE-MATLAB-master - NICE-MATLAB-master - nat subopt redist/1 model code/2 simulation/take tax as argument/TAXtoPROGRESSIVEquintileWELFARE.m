function W = TAXtoPROGRESSIVEquintileWELFARE(tax,rho,eta,P,varargin)

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
[c] = TAXEDcquintilesFROMtax(tax,P,Tmax,tmax);
L = P.Lq;

W = equintileWelfareIT(c,L,rho,eta,Tmax);