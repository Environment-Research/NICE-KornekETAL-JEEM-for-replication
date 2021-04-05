function [L] = population(Pop0,poprates)
T=60;
I=12;
L=zeros(T,I);
L(1,:)=Pop0;
for n=1:12;
    for t=2:31;
        L(t,n)=L(t-1,n)*exp(poprates(t-1,n)*10);
    end
    for t=32:T;
        L(t,n)=L(31,n);
    end
end
