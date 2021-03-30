%Generates the exogenous time series as function of given parameters
function [param] = exogenous(param_i,DEEPrandP)

T=60;
I=12;

%pb: backstop price
%   TxI array determined by 
%   THE CERTAIN PARAMETERS
    %   Th            inital to final backstop price ratio

    %   RL            region to world backstop price ratio
    %   du            rate of decline before tau
    %   dd            rate of decline after tau
    %   tau           period in which rate of decline changes
    %   p0 = RL*pw    initial vector of backstop prices    1000 2005 USD per tC

Th=param_i(2).Th;
RL=param_i(2).RL;

du=param_i(2).du;
dd=param_i(2).dd;
tau=param_i(2).tau;    
%   THE RANDOM PARAMETERS
    %   pw            inital world backstop price          1000 2005 USD per tC
pw=DEEPrandP.pw;

%   pb(t,i) = Th*p0(i) + (1-du)*(pb(t-1,i)-Th*p0(i)) if t<tau
%             pb(t-1,i)*dd                           if t>= tau

pb = backstop(Th,RL,pw,du,dd,tau);

pb_={'pb',pb,'backstop price as function of time','1000 of 2005 USD per tC'};

%sigma: Emissions to output ratio
%   THE CERTAIN PARAMETERS
    %   TxI array determined by
    %   gT      trend growth rate
    %   delsig  growth decline rate

    %   adj15   2015 adjustment factor
    %   Y0      2005 output         trillions 2005 USD  1xI
    %   E0      2005 emissions      Mtons of CO2 equivalent 1xI
gT=param_i(2).gT;
delsig=param_i(2).delsig;

adj15=param_i(2).adj15;
Y0=param_i(2).Y0;
E0=param_i(2).E0;
%   THE RANDOM PARAMETERS
    %   sighisT historic growth rate times adjustment   1xI
sighisT=DEEPrandP.sighisT;    
    
%   sigma(1,i) = E0(i)/(100*Y0(i)) 1xI
%   sigma(t,i) = sig0(i)*exp(gT)*exp((sighisT(i)-gT)*(1-delsig)^(t-1))
%   except for t = 1 because of the adj15 ajustment

sigma = sig(gT,delsig,sighisT,adj15,Y0,E0);

sigma_={'sigma',sigma,'emissions to output ratio as function of time','tC per 1000 2005 USD of GDP'};


%th1: multiplicative parameter in the abatement cost function
%   th2     exponent in the abatement cost function  == 2.8
%   th1(t,i) = pb(t,i)*sigma(t,i)/th2

th2=param_i(2).th2;

th1 = (pb.*sigma)/th2;

th1_={'th1',th1,'multiplicative factor in abatement cost function',''};


%L: population path for all 12 regions
%   TxI array determined by
%   Pop0        Popuation in 2005
%   poprates    Exogenous population growth rates for the first 30 periods

Pop0=param_i(2).Pop0;
poprates=param_i(2).poprates;

L = population(Pop0,poprates);

L_={'L',L,'Population of regions across time','millions'};

%Fex: Exogenous forcing (from other GHGs)
%   Tx1 array determined by 
%   Fex2000         Forcings in 2000
%   Fex2100         Forcings in 2100
%   Fex(t) = Fex2000 + 0.1*(Fex2100-Fex2000)*(t-1)

Fex2000=param_i(2).Fex2000;
Fex2100=param_i(2).Fex2100;

Fex = forcingEx(Fex2000,Fex2100);

Fex_={'Fex',Fex,'Exogenous forcing due to other GHGs','Watts per sqm'};

%TFP; Total factor productivity
%   THE CERTAIN PARAMETERS
    %   TxI array determined by
    %   A0      initial TFP calibrated                      
 
    %   tgl     longrun tfp growth (in US)
    %   delA    decline in tfp growth (in US)
    %   gamma   elasticity of capital in production         
    %   Crate   Convergence rate per decade
    %   Cratio  Convergence ratio
    %   y0      initial per capita consumption              
A0=param_i(2).A0;

delA=param_i(2).delA;
gamm=param_i(2).gamm;
Crate=param_i(2).Crate;
Cratio=param_i(2).Cratio;
y0=param_i(2).y0;
tgl=param_i(2).tgl;
%   THE RANDOM PARAMETERS
    %   gy0     initial growth in consumption per capita   
gy0=DEEPrandP.gy0;

[tfp] = tfactorp(A0,gy0,tgl,delA,gamm,Crate,Cratio,y0);

tfp_={'tfp',tfp,'Total factor productivity of regions across time',''};

%EL: Emissions from land use change
%   TxI array determined by
%   EL0 initial emissions due to land use change
%   delL rate of decline of these

EL0=param_i(2).EL0;
delL=param_i(2).delL;

[EL] = landuse(EL0,delL);

EL_={'EL',EL,'Emissions due to land use change','Gtons of carbon per year'};

%xi: The temperature Forcing and temperature flow parameters
%   THE CERTAIN PARAMETERS
    %   xi2 the six right elements of the vector
xi2 = param_i(2).xi2;
%   THE RANDOM PARAMETER
    %   xi1 the climate sensitivity parameter
xi1 = DEEPrandP.xi1;

xi =[xi1,xi2];
xi_ = {'xi',xi,'FCO22X,speed of adjustment for T1,Equilibrium temp increase for CO2 doubling,coeff of heat loss from T1 to T2,coeff of heat gain T2 from T1,Mass of carbon in 1750,epsilon','Climate coefficients'};

%TrT: Transition matrix for the temperature flow
% function of the parameters in xi

TrT=[-xi(2)*(xi(1)/xi(3)+xi(4)),xi(2)*xi(4);xi(5),-xi(5)]'+eye(2);
TrT_={'TrT',TrT,'Transition matrix for temperature flow','The underlying parameters are in xi'};

%TrM: Transition matrix for carbon flow
%   CERTAIN PARAMETERS
    %   TrML: lower two thirds of matrix
TrML = param_i(2).TrML;
%   RANDOM PARAMETERS
    %   transfer coefficients in row 1
TrM12 = DEEPrandP.TrM12;

TrM = [100-TrM12,TrM12,0;TrML];
TrM_ = {'TrM',TrM,'Carbon cycle transition matrix','percent of transfer per decade of interaction'};

%PSI: damage parameters
%   CERTAIN PARAMETERS
    %   psi1: the parameters already in Nordhaus
psi1 = param_i(2).psi1;
%   RANDOM PARAMETERS
    %psi7: coefficient on T^7
psi7 = DEEPrandP.psi7;
psi7vec = ones(1,12).*psi7;
psi = [psi1;psi7vec];

psi_ = {'psi',psi,'Parameters of damage function: Linear,Square,catastrophic,threshold,exponent,T^7',''};

%include the generated series into the new data structure, with the input

a=struct2cell(param_i);
b=[a;pb_;sigma_;th1_;L_;Fex_;tfp_;EL_;xi_;TrT_;TrM_;psi_];
param = cell2struct(b,b(:,1),1);




