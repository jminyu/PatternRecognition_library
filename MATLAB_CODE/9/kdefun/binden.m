function [xb,cb]=binden(n,x)
% ----------------------------------------------------------------
% function [xb,cb]=binden(n,x)
% ----------------------------------------------------------------
% Given a 1-dimensional data set this function
% devides the space into n bins and calculates bin counts. 
%
% ------------------------------------------------------------------
% INPUT
%  n       number of bins 
%  x       data, row vector 
% OUTPUT
%  xb      bin centers. xb(i) center of bin_i
%  cb      bin counts. cb(i)=#j, where x_j's in Bin_i 
%-------------------------------------------------------------------
 
xmax=max(x);
xmin=min(x);
binwidth=(xmax-xmin)/(n);
for i=1:n
  xb(i)=binwidth*(i-0.5)+xmin;           %  bincenter
end
cb=hist(x,xb);


