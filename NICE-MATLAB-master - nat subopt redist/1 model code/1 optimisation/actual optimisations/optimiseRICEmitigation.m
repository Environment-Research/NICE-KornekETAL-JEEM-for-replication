function endo = optimiseRICEmitigation(P,init,Tmax,options)

obj = @(argument)(-MUtoWELFARE(argument,P,Tmax));
[optimu,W,exitflag] = fmincon(obj,init,[],[],[],[],zeros(size(init)),ones(size(init)),[],options);
endo = varsFROMmu(optimu,P,Tmax);
endo.E(1,:) = P.E0;
endo.tax = 1000*endo.mu.^(endo.th2-1).*endo.pb;
endo.initialGuess = init;
endo.W = W;
endo.options = options;
endo.exitflag = exitflag;
endo.misc = {};