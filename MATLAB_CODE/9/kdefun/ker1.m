function ker=ker1(x); 
% the triangular kernel
%  INPUT:
%  x     size 1,n vector
%  OUTPUT:
%  ker   size 1,n vector
k=(1-abs(x));
ker=max(k,(zeros(1,length(x))));
