function p = pdf(m, v, x)
% calculate gaussian
%
% inputs:
%  m -- mean vector, SIZE*1
%  v -- variance vector, SIZE*1
%  x -- observation vector, SIZE*1
%
% output:
%  p -- output probability

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

p = (2 * pi * prod(v)) ^ -0.5 * exp(-0.5 * (x-m) ./ v * (x-m)');
