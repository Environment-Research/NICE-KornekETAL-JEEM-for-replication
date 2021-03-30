function c = globalTAXcquintilesFROMtax(tax,P,Tmax,tmax)
% calculates the consumption path (or path of any other variable for that
% matter) at a given tax rate and given draw of the parameter array
% Tax is implemented up to period tmax, from when on full mitigation is assumed

% assumption here is of logarithmic utility and full depreciation (at a
% decadal time scale) yielding the closed form (constant) savings rate
% s=beta%gamma


%   PRELIMINARIES
    A=P.A;
    L=P.L/1000;
    para=P.para;
    %ODA
    ODAtau = P.ODAtau;
    %   Consumption
    c = zeros(Tmax,5,12);
    q = P.q/100*5; %quintiles
    d = P.d/100*5; %damage quintiles
    p = P.p; %convex weight between downward skew and proportional damage
    tol = P.tol; %consumption tolerance
    %   Capital
    K = zeros(60,12);
    sigma=P.sigma;
    pb=P.pb*1000;
    th1 = P.th1;
    th2 = P.th2;
    %capital
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
cbar = (1-S(1,:)).*Q(1,:)./L(1,:);
c(1,:,:) = bsxfun(@times,cbar.*(1+D(1,:)),q) - bsxfun(@times,cbar.*D(1,:),p*d+(1-p)*q);
cake = L(1,:)*squeeze(sum(ODAtau*c(1,:,:),2))/5;
c(1,:,:) = (1-ODAtau)*c(1,:,:) + cake/sum(L(1,:),2);
K(2,:) = S(1,:).*Q(1,:)*10;
Y(2,:) = A(2,:).*L(2,:).^(1-para(4)).*K(2,:).^para(4);
E(2,:) = (1-mu(2,:)).*sigma(2,:).*Y(2,:);
M(3,:) = Mflow(M(2,:),sum(E(2,:) + EL(2,:)),TrM);
D(2,:) = damageRANDOM(T(2,1),psi);
AD(2,:) = (1-lam(2,:))./(1+D(2,:));
Q(2,:) = AD(2,:).*Y(2,:);
cbar= (1-S(2,:)).*Q(2,:)./L(2,:);
c(2,:,:) = max(bsxfun(@times,cbar.*(1+D(2,:)),q) - bsxfun(@times,cbar.*D(2,:),p*d+(1-p)*q),tol);
cake = L(2,:)*squeeze(sum(ODAtau*c(2,:,:),2))/5;
c(2,:,:) = (1-ODAtau)*c(2,:,:) + cake/sum(L(2,:),2);
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
    cbar= (1-S(t,:)).*Q(t,:)./L(t,:);
    c(t,:,:) = max(bsxfun(@times,cbar.*(1+D(t,:)),q) - bsxfun(@times,cbar.*D(t,:),p*d+(1-p)*q),tol);
    cake = L(t,:)*squeeze(sum(ODAtau*c(t,:,:),2))/5;
    c(t,:,:) = (1-ODAtau)*c(t,:,:) + cake/sum(L(t,:),2);
    K(t+1,:) = S(t,:).*Q(t,:)*10;
end
T(Tmax,:) = tempfor(M(Tmax,1),Fex(Tmax),xi,TrT,T(Tmax-1,:));
D(Tmax,:) = damageRANDOM(T(Tmax,1),psi);
AD(Tmax,:) = (1-lam(Tmax,:))./(1+D(Tmax,:));
Q(Tmax,:) = AD(Tmax,:).*A(Tmax,:).*L(Tmax,:).^(1-para(4)).*K(Tmax,:).^para(4);
cbar= (1-S(Tmax,:)).*Q(Tmax,:)./L(Tmax,:);
c(Tmax,:,:) = max(bsxfun(@times,cbar.*(1+D(Tmax,:)),q) - bsxfun(@times,cbar.*D(Tmax,:),p*d+(1-p)*q),tol);
%cbarfull = (1-S(1:Tmax,:)).*Q(1:Tmax,:)./L(1:Tmax,:);