function [f_est,x_est]=kde(x,h,ker,par)
%
% [f_est,x_est]=kde(x,h,'ker','par')
%----------------------------------------------------------------------
% The kernel density estimator (1 dimension)
% INPUT:
% x      a row vector containing the data
% h      smoothing parameter 
% ker    a string containing the chosen kernel. For example 'ker1'
% par    a string containing the chosen plot element. For example 'r--'
%OUTPUT:
% f_est  a row vector containing the estimates calculated at the
%        evaluation points x_est
% x_est  a row vector containing the evaluation points  
%---------------------------------------------------------------------
n=length(x);
x_est=linspace(min(x),max(x),200);
n_est=length(x_est);
f_est=zeros(1,n_est);
for i=1:n_est
  ero_i=x_est(i)-x;                
  eval(['Ki_h=',ker,'(ero_i/h);'])         
  f_est(i)=(1/(n*h))*sum(Ki_h);
end

plot(x_est,f_est,par)
