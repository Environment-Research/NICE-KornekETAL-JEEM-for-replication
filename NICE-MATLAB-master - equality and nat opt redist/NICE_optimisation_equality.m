%% This is the interface file for NICE, in which regional abatement is varied independently
p_loc = genpath(cd());
addpath(p_loc);
loadDATAforNICE
% set omegas for optimal national redistribution
omegaopt = ones(5,12);
rhov = [0.02]; %[0.015]; %[0 0.01 0.02];
etav =[0.5 1 1.5 2]; %[0 1.01 2 3];
xiv = [-0.5]; %x=1 -> damages are proportional to income; x=0 damages are independent of income; x=-1 ->damages are inverse proportional to income 
omegav = [1];
T7v = [0]; %[0 0.319 0.48];
for i = 1 %1:3
    rho = rhov(i);
for j = 1:length(etav)%[1 4] %2:3
    eta = etav(j);
for k = 1 %[1 3];
    omega = omegav(k);
for l = 1
    xi = xiv(l); 
for m = 1:1
    T7 = T7v(m);
% variables not being looped over     
    q = aggregateq;
    %omegaopt=q.^eta; %UK DK 29.5.2017
    Lq = Lquintiles;
    tol = 0.1;
    d = damageelasticity(xi, q);
    z = damageelasticity(omega, q);
    Px = createP(certainPARAMETERS, dparam_SLR, T7);
    P = setP(Px,rho,eta,T7,q,xi,d,omega,z,Lq,tol);
    P.omegaopt = omegaopt; % UK DK 22.5.2017 "CASE1"
%PARAMETERS CONTROLLING OPTIMISATION
    Tmax = 59;%number of periods (from 2005) the model runs (60 is max)
    dim = 20; %dimension of maximand (mitigation rate vector)
    init = ones(dim,12)*0.2;
    options = optimset('MaxFunEvals',500000,'FinDiffType','central','Algorithm','interior-point','TolX',1e-12,'TolFun',1e-5,'MaxIter',1000); %U.K. 05.12.2018: different options to achieve better convergence and higher tolerance

%OPTIMISATION
    endo = optimiseNICEmitigation(P,init,Tmax,options);
    results = endo;  %results will be stored extra when checked whether converged and, if not converged, optimization is redone with computationally more extensive alternative algorithm
    
        if (results.exitflag~=1)
        'no min 1'
             options = optimset('MaxFunEvals',500000,'FinDiffType','central','Algorithm','sqp','TolX',1e-12,'TolFun',1e-5,'MaxIter',1000); %various other options
            %OPTIMISATION 2: use better but also slower algorithm when
            %first one failed:
            endo = optimiseNICEmitigation(P,init,Tmax,options);
            results=endo;     
            if (results.exitflag~=1)
                'no min 2'
                return
            end
        end
        
        switch eta
                case 1 
                    results_CASE1a=results; %w. eta=1
                case 1.5 
                    results_CASE1b=results; %w. eta=1.5
                case 0.5
                    results_CASE1c=results; %w. eta=0.5
                case 2
                    results_CASE1d=results; %w. eta=2
                    
 
 
        end
       clear P;
end
end
end
end
end
