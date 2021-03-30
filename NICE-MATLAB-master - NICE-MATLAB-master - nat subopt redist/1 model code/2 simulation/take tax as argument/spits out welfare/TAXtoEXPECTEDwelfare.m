function W = TAXtoEXPECTEDwelfare(flag,tax,rho,etat,etai,etao,Prandom,varargin)
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
[c] = randomctax(tax,Prandom,Tmax,tmax);
L = repmat(Prandom{1}.L,[1,1,length(Prandom)]);
switch flag
    case 'iot'
        W = eWelfareIOT('full',c,L,rho,etat,etai,etao,Tmax);
    case 'ito'
        W = eWelfareITO('full',c,L,rho,etat,etai,etao,Tmax);
end