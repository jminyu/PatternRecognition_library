function ker=ker4(x);
% 
% the Biweigth kernel
%
% input: x size 1,n vector
% output: ker size 1,n vector
xu=min(abs(x),ones(1,length(x)));
k=15/16*(1-xu.^2).^2;



