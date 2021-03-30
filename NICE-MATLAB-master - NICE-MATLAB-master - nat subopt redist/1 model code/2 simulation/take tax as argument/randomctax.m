function [c] = randomctax(tax,Prandom,Tmax,tmax)
%tic
s = length(Prandom);
c = zeros(Tmax,12,s);
for i=1:s
    c(:,:,i) = cFROMtax(tax,Prandom{i},Tmax,tmax);
end
%toc