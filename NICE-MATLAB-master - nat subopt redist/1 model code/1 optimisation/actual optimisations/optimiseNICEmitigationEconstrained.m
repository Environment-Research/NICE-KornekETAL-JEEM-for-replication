function endo = optimiseNICEmitigationEconstrained(P,init,const,Tmax,tconst,options)

obj = @(argument)(-MUtoquintileWELFAREwabatement(argument,P,Tmax));
con = @(argument)(E_FROMmu(argument,P,const,tconst));
[optimu,W,exitflag] = fmincon(obj,init,[],[],[],[],zeros(size(init)),ones(size(init)),con,options);
endo = varsFROMmu(optimu,P,Tmax);
endo.c = cquintilesFROMmitigationWabatement(optimu,P,Tmax);
endo.E(1,:) = P.E0;
endo.tax = endo.mu.^(endo.th2-1).*endo.pb;
endo.initialGuess = init;
endo.W = W;
endo.options = options;
endo.exitflag = exitflag;
endo.misc = {};