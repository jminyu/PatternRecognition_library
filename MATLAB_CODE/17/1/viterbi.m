function [prob,q] = viterbi(hmm, O)
% viterbi recognition and decoding
%
% inputs:
%  hmm  -- hmm model struct
%  O    -- input observation sequence, T*D
%          T is number of frames, D is order of speech parameter
% outputs:
%  prob -- output probability
%  q    -- state sequence

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

init  = hmm.init;	% initial probability
trans = hmm.trans;	% transition probability
mix   = hmm.mix;	% gaussian mixture
N     = hmm.N;		% number of HMM states
T     = size(O,1);	% number of frames

% calculate log(init)
ind1 = find(init>0);
ind0 = find(init<=0);
init(ind0) = -inf;
init(ind1) = log(init(ind1));

% calculate log(trans)
ind1 = find(trans>0);
ind0 = find(trans<=0);
trans(ind0) = -inf;
trans(ind1) = log(trans(ind1));

% initialization
delta = zeros(T,N);
fai   = zeros(T,N);
q     = zeros(T,1);

% t=1
x = O(1,:);
for i = 1:N
	delta(1,i) = init(i) + log(mixture(mix(i),x));
end

% t=2:T
for t = 2:T
for j = 1:N
	[delta(t,j) fai(t,j)] = max(delta(t-1,:) + trans(:,j)');
	x = O(t,:);
	delta(t,j) = delta(t,j) + log(mixture(mix(j),x));
end
end

% final probability and state
[prob q(T)] = max(delta(T,:));

% trace back the best state sequence
for t=T-1:-1:1
	q(t) = fai(t+1,q(t+1));
end
