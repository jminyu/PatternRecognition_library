function ker=ker2(x);
% 
% the Epanechikov kernel
% input: x size 1,n vector
% output: ker size 1,n vector
k=0.75*(1-0.2*(x.^2))*sqrt(5);
ker=max(k,(zeros(1,length(x))));



