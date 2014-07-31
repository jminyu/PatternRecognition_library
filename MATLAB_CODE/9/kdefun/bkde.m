function [f_est,x_est]=bkde(xb,cb,h,ker,par)
%
% [f_est,x_est]=bkde(xb,cb,h,'ker','par')
%----------------------------------------------------------------------
% The binned kernel density estimator 
% INPUT:
% xb     a row vector containing the bin centers
% cb     the corresponding bincounts
% h      smoothing parameter
% ker    a string containing the chosen kernel. For example 'ker1'
% par    a string containing the chosen plot element. for example 'r--'
%OUTPUT:
% f_est  a row vector containing the estimates calculated at
%        400 evaluation points x_est
%---------------------------------------------------------------------

n=sum(cb);
x_est=linspace(min(xb),max(xb),400);
n_est=length(x_est);
f_est=zeros(1,n_est);

for i=1:n_est
  ero_i=x_est(i)-xb;                
  eval(['Ki_h=',ker,'(ero_i/h);'])         
  f_est(i)=(1/(n*h))*sum(cb.*Ki_h);
end
plot(x_est,f_est,par)
