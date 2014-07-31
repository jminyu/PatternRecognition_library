function prob = mixture(mix, x)
% calculate output probability
%
% inputs:
%  mix  -- gaussian mixture
%  x    -- input vector, SIZE*1
% output:
%  prob -- output probability

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

prob = 0;
for j = 1:mix.M
	m = mix.mean(j,:);
	v = mix.var (j,:);
	w = mix.weight(j);
	prob = prob + w * pdf(m, v, x);
end

% prevent from overflow in viterbi.m when calling log(prob)
if prob==0, prob=realmin; end
