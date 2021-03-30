function endo = optimiseRICE(P,init,Tmax,tmax,dim,options)

pbMax = 1000*max(P.pb,[],2);
pbM2 = pbMax(2:60);
obj = @(argument)(-TAXtoWELFARE(argument,P,Tmax,tmax));
[optitax,W,exitflag] = fmincon(obj,init,[],[],[],[],zeros(size(init)),pbM2(1:dim),[],options);

endo = varsFROMtax(optitax,P,Tmax,tmax);
endo.E(1,:)=P.E0;
endo.tax = [0; optitax];
endo.initialGuess = init;
endo.W = W;
endo.options = options;
endo.exitflag = exitflag;
endo.misc = {};