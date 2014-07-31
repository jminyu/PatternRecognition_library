function ker=ker5(x);
% 
% the Rectangular kernel
% input: x size 1,n vector
% output: ker size 1,n vector
[ker,l]=max([abs(x);ones(1,length(x))]);
ker(l==1)=0;
ker(l==2)=0.5;
