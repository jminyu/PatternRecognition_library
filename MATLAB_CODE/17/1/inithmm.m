function hmm = inithmm(samples, M)
% initialize hmm parameters
%
% inputs:
%  samples -- speech sample structure
%  M       -- number of pdfs for each state, eg., [3 3 3 3]
%
% output:
%  hmm     -- initialized hmm structure

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

K = length(samples);	% number of speech samples
N = length(M);			% number of hmm states
hmm.N = N;
hmm.M = M;

% initial probability
hmm.init    = zeros(N,1);
hmm.init(1) = 1;

% transition probability
hmm.trans=zeros(N,N);
for i=1:N-1
	hmm.trans(i,i)   = 0.5;
	hmm.trans(i,i+1) = 0.5;
end
hmm.trans(N,N) = 1;

% initial cluster of pdfs
% equally segmentation
for k = 1:K
	T = size(samples(k).data,1);
	samples(k).segment=floor([1:T/N:T T+1]);
end

% cluster vectors belong to each states using K-Means
for i = 1:N
	% assemble vectors of the same cluster and state into one vector
	vector = [];
	for k = 1:K
		seg1 = samples(k).segment(i);
		seg2 = samples(k).segment(i+1)-1;
		vector = [vector ; samples(k).data(seg1:seg2,:)];
    end
	mix(i) = getmix(vector, M(i));
end

hmm.mix = mix;

function mix = getmix(vector, M)
% K-Means clustering, and return the mean and variance and weights of pdfs
% inputs:
%  vector -- input vectors
%  M      -- number of pdfs
% output:
%  mix -- gaussian mixture structure

[mean esq nn] = kmeans(vector,M);

% calculate variance, in diagonal
for j = 1:M
	ind = find(j==mean);
	tmp = vector(ind,:);
	var(j,:) = std(tmp);
end

% get number of vectors for each pdf, and convert into weights
weight = zeros(M,1);
for j = 1:M
	weight(j) = sum(find(j==mean));
end
weight = weight/sum(weight);

% return gaussian mixture
mix.M      = M;
mix.mean   = esq;		% M*SIZE
mix.var    = var.^2;	% M*SIZE
mix.weight = weight;	% M*1
