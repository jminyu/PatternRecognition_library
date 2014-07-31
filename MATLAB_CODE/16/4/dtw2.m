function dist = dtw2(test, ref)
% Compare two model using a efficient DTW
% inputs:
%   test -- test model
%   ref  -- reference model
%
% output:
%   dist -- matching score

%      Copyright (C) Qiang He, 2001
%
%   This file is part of MATLAB speech recognition software. Homepage is at:
%     http://go.163.com/energy/speech.htm
%
%   About the author:
%     Qiang He (Ph.D.)
%     E.E., Tsinghua University, Beijing, P.R.C., 100084
%     Email: obase@163.net
%     WWW  : http://go.163.com/energy
%     Tel  : +86 13910051159
%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You can obtain a copy of the GNU General Public License from
%   ftp://prep.ai.mit.edu/pub/gnu/COPYING-2.0 or by writing to
%   Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global x y_min y_max
global t r
global D d
global m n

t = test;
r = ref;
n = size(t,1);
m = size(r,1);

d = zeros(m,1);
D = ones(m,1) * realmax;
D(1) = 0;

% if the length of two templates differ too much, return fail
if (2*m-n<3) | (2*n-m<2)
	dist = realmax;
	return
end

% find the ranges to match
xa = round((2*m-n)/3);
xb = round((2*n-m)*2/3);

if xb>xa
	%xb>xa, match in the following 3 fields:
	%        1   :xa
	%        xa+1:xb
	%        xb+1:N
	for x = 1:xa
		y_max = 2*x;
		y_min = round(0.5*x);
		warp
	end
	for x = (xa+1):xb
		y_max = round(0.5*(x-n)+m);
		y_min = round(0.5*x);
		warp
	end
	for x = (xb+1):n
		y_max = round(0.5*(x-n)+m);
		y_min = round(2*(x-n)+m);
		warp
	end
elseif xa>xb
	%xa>xb, match in the following 3 fields:
	%        0   :xb
	%        xb+1:xa
	%        xa+1:N
	for x = 1:xb
		y_max = 2*x;
		y_min = round(0.5*x);
		warp
	end
	for x = (xb+1):xa
		y_max = 2*x;
		y_min = round(2*(x-n)+m);
		warp
	end
	for x = (xa+1):n
		y_max = round(0.5*(x-n)+m);
		y_min = round(2*(x-n)+m);
		warp
	end
elseif xa==xb
	%xa=xb, match in the following 2 fields:
	%        0   :xa
	%        xa+1:N
	for x = 1:xa
		y_max = 2*x;
		y_min = round(0.5*x);
		warp
	end
	for x = (xa+1):n
		y_max = round(0.5*(x-n)+m);
		y_min = round(2*(x-n)+m);
		warp
	end
end

% retyrn match score
dist = D(m);

function warp
global x y_min y_max
global t r
global D d
global m n

d = D;
for y = y_min:y_max
	D1 = D(y);
	if y>1
		D2 = D(y-1);
	else
        D2 = realmax;
	end
	if y>2
		D3 = D(y-2);
	else
        D3 = realmax;
	end
    d(y) = sum((t(x,:)-r(y,:)).^2) + min([D1,D2,D3]);
end

D = d;