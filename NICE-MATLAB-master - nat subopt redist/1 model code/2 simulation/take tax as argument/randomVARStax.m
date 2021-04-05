function [ENDOrandom] = randomVARStax(tax,Prandom,varargin)
%tic
if isempty(varargin)
    Tmax=60;
    tmax=60;
elseif length(varargin) == 1
    Tmax=varargin{1};
    tmax=60;
elseif length(varargin) == 2
    Tmax=varargin{1};
    tmax=varargin{2};
end
s = length(Prandom);
ENDOrandom = {};
for i=1:s
    ENDOrandom{i} = varsFROMtax(tax,Prandom{i},Tmax,tmax);
end
%toc