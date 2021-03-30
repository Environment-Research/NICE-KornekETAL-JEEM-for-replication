function endo = optimiseNICEmitigation(P,init,Tmax,options)

%scale mu to have more equal changes in objective function along the time dimension
rho=P.rho;
dis =1/(1+rho);
R59   = bsxfun(@power,dis,10*(0:58));

   R=repmat(transpose(R59(2:((size(init,1))+1))),1,12); 
   R_minus1=1./R; 



obj = @(argument)(-MUtoquintileWELFAREwabatement(R_minus1.*argument,P,Tmax));%with scaled mu
[optimu_scale,W,exitflag] = fmincon(obj,init,[],[],[],[],zeros(size(init)),R.*ones(size(init)),[],options);%with scaled mu
optimu=R_minus1.*optimu_scale;%rescale mu
endo = varsFROMmu(optimu,P,Tmax);
endo.c = cquintilesFROMmitigationWabatement(optimu,P,Tmax);
endo.E(1,:) = P.E0;
endo.tax = 1000*endo.mu.^(endo.th2-1).*endo.pb;
endo.initialGuess = init;
endo.W = W;
endo.options = options;
endo.exitflag = exitflag;
endo.misc = {};