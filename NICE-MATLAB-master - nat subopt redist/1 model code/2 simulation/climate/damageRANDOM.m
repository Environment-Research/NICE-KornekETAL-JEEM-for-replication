function [D] = damageRANDOM(T,psi)
%Calculates the damage function in all regions given the average
%atmospheric temperature over pre industrial levels
D = (psi(1,:).*T+psi(2,:).*T.^2+(psi(6,:).*T).^7).*0.01;