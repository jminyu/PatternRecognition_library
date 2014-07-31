function [xb1,p1]=histo(x,binwidth,shift,par)
% ----------------------------------------------------------------
% function [xb1,p1]=histo(x,binwidth,shift,'par') 
% ----------------------------------------------------------------
% the histogram with different bandwidth and sideway shift values
% Hint: the choise shift=bandwidth/2 places bin edges at the origin 
% ------------------------------------------------------------------
% INPUT
%  x          data, a row vector 
%  binwidth   the binwidth  
%  shift      the amount of sideway shift
%  'par'      the plot parameter  for example 'r--'
% OUTPUT
%  xb1        bin centers xb(i) center of bin_i
%  p1         bin propotions p(i)  
%-------------------------------------------------------------------
xmax=max(x);
xmin=min(x);

alaraja=floor(xmin/binwidth)*binwidth;
ylaraja=ceil(xmax/binwidth)*binwidth;

nbin=(ylaraja-alaraja)/binwidth;    % the number of bins

ind=(0:nbin-1);
xb1=binwidth*ind+alaraja+shift;         % the bincenters
p1=hist(x,xb1)/(length(x)*binwidth);    % the bin propotions
 
xb=[xb1-binwidth/2;xb1;xb1+binwidth/2];
xb=xb(:)';

p=[p1;p1;p1];
p=p(:)';

xb=[min(xb),xb,max(xb)];
p=[0,p,0];

plot(xb,p,par)




