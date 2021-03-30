function [pb] = backstop(Th,RL,pw,du,dd,tau)
T = 60;
I = 12;

%pb: backstop price
%   TxI array determined by 
%   Th            inital to final backstop price ratio
%   pw            inital world backstop price          1000 2005 USD per tC
%   RL            region to world backstop price ratio
%   du            rate of decline before tau
%   dd            rate of decline after tau
%   tau           period in which rate of decline changes
%   p0 = RL*pw    initial vector of backstop prices    1000 2005 USD per tC
%   pb(t,i) = Th*p0(i) + (1-du)*(pb(t-1,i)-Th*p0(i)) if t<tau
%             pb(t-1,i)*dd                           if t>= tau

taut = (tau - 1995)/10;
p0 = zeros(1,I);
p0 = RL*pw;
pb = zeros(T,I);
pb(1,:) = p0;
for i=1:I;
    for t = 2:taut;
        pb(t,i) = Th*p0(i) + (1-du)*(pb(t-1,i)-Th*p0(i));
    end
    for t = taut+1:T;
        pb(t,i) = pb(t-1,i)*dd;
    end
end