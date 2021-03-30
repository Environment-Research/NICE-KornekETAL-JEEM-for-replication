function endo = optimiseNICEEconstrained(P,init,const,tconst,Tmax,tmax,dim,options)

pbMax = 1000*max(P.pb,[],2);
pbM2 = pbMax(2:60);
obj = @(argument)(-TAXtoquintileWELFAREwabatement(argument,P,Tmax,tmax));
con = @(argument)(E_FROMtax(argument,P,const,tconst,tmax));
[optitax,W,exitflag] = fmincon(obj,init,[],[],[],[],zeros(size(init)),pbM2(1:dim),con,options);
endo = varsFROMtax(optitax,P,Tmax,tmax);
endo.c = cquintilesFROMtaxwabatement(optitax,P,Tmax,tmax);
endo.E(1,:) = P.E0;
endo.tax = [0; optitax];
endo.initialGuess = init;
endo.W = W;
endo.options = options;
endo.exitflag = exitflag;
endo.misc = {};