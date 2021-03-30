function [Elim,nul] = E_FROMtax(tax,P,const,varargin)
% calculates the consumption path (or path of any other variable for that
% matter) at a given tax rate and given draw of the parameter array
% Tax is chosen up to tmax, from when on full mitigation is assumed

% assumption here is of logarithmic utility and full depreciation (at a
% decadal time scale) yielding the closed form (constant) savings rate
% s=beta%gamma


if isempty(varargin)
    Tmax=60;
    tmax=60;
elseif length(varargin) == 1
    Tmax=varargin{1};
    tmax=60;
elseif length(varargin) == 2
    Tmax=varargin{1};
    tmax=varargin{2};
end

%   PRELIMINARIES
    A=P.A;
    L=P.L/1000;
    para=P.para;
    sigma=P.sigma;
    pb=P.pb*1000;
    th1 = P.th1;
    th2 = P.th2;
    %capital
    %   Capital
    K = zeros(60,12);
    K(1,:) = P.K0;
    %   temperatures
    T=zeros(60,2);
    T(1,:) = P.T0;
    T(2,:) = P.T1;
    %   Initial mass of carbon in the three reservoirs
    M=zeros(60,3);
    M(1,:) = P.M0;
    M(2,:) = P.M1;
    %   in carbon cycle and forcing: climate module
    EL = P.EL; %emissions due to land use change
    Fex = P.Fex; %Exogenous forcing
    TrM=P.TrM; xi=P.xi; TrT=P.TrT; psi=P.psi;

%savings rate
s1 = para(4)/(1+para(1))^10;
S = ones(60,12)*s1;
%the tax
%the tax vector in thousands of 2005 USD
ltax = length(tax) +1;
%if the tax vector is shorter than 59, then the last available tax is
%replicated over the later periods
TAX = [0; ones(59,1)*tax(ltax-1)];
TAX(2:ltax) = tax;
%optimal emissions control rate given tax
mu60 = max(min(1,bsxfun(@rdivide,TAX,pb).^(1/(th2-1))),0);
mu = ones(60,12);
mu(1:tmax,:) = mu60(1:tmax,:);
%abatement cost
lam = th1.*mu.^th2;
D(1,:) = damageRANDOM(T(1,1),psi);
AD(1,:) = (1-lam(1,:))./(1+D(1,:));
Q(1,:) = AD(1,:).*A(1,:).*L(1,:).^(1-para(4)).*K(1,:).^para(4);
K(2,:) = S(1,:).*Q(1,:)*10;
Y(2,:) = A(2,:).*L(2,:).^(1-para(4)).*K(2,:).^para(4);
E(2,:) = (1-mu(2,:)).*sigma(2,:).*Y(2,:);
M(3,:) = Mflow(M(2,:),sum(E(2,:) + EL(2,:)),TrM);
D(2,:) = damageRANDOM(T(2,1),psi);
AD(2,:) = (1-lam(2,:))./(1+D(2,:));
Q(2,:) = AD(2,:).*Y(2,:);
K(3,:) = S(2,:).*Q(2,:)*10;
for t=3:(Tmax-1)
    Y(t,:) = A(t,:).*L(t,:).^(1-para(4)).*K(t,:).^para(4);
    E(t,:) = (1-mu(t,:)).*sigma(t,:).*Y(t,:);  
    M(t+1,:) = Mflow(M(t,:),sum(E(t,:) + EL(t,:)),TrM);
    Mav = (M(t+1,1) + M(t,1))/2;
    T(t,:) = tempfor(Mav,Fex(t),xi,TrT,T(t-1,:));
    D(t,:) = damageRANDOM(T(t,1),psi);
    AD(t,:) = (1-lam(t,:))./(1+D(t,:));
    Q(t,:) = AD(t,:).*Y(t,:);
    K(t+1,:) = S(t,:).*Q(t,:)*10;
end
Y(Tmax,:) = A(Tmax,:).*L(Tmax,:).^(1-para(4)).*K(Tmax,:).^para(4);
E(Tmax,:) = (1-mu(Tmax,:)).*sigma(Tmax,:).*Y(Tmax,:); 

Elim = sum(E(2:Tmax,:),2)*3.6-const;
nul = [];