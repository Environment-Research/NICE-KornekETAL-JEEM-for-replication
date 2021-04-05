function P = collateP(paramCERTAIN,DEEPrandP)
%Here paramCERTAIN contains those variables from the initial calibration
%which are not affected by the random variables. We can use the output of
%initialNord(dparam_i) or initialsteadystate(dparam_i).
%the difference is that if you want the initial marginal product
%of capital calibration to include the (1-gamm) term necessary in the 
%ramsey equation

%currently we are sticking to NORDHAUS


%REPLACE THE RANDOM VARIABLES IN param_i WITH THE RADOM REALISATIONS
%CREATE CELL STRUCTURE WITH A DIFFERENT param_i FOR EVERY DRAW

for i=1:length(DEEPrandP)
    [param{i}] = exogenous(paramCERTAIN,DEEPrandP(i));
    P(i) = simplifyparameterstructure(param{i});
end

%END