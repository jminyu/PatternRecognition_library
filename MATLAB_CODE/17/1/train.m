function [hmm, pout] = train(samples, M)
% training of hmm
%
% inputs:
%  samples -- speech sample structure
%  M       -- number of pdfs for each state, eg., [3 3 3 3]
%
% output:
%  hmm     -- hmm structure after training

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
K = length(samples);

hmm = inithmm(samples, M);

for loop = 1:40
	fprintf('\ntraining loop %d\n\n',loop)
	hmm = baum(hmm, samples);

	% calculate total output probability
	pout(loop)=0;
	for k = 1:K
		pout(loop) = pout(loop) + viterbi(hmm, samples(k).data);
	end

	fprintf('total output probability(log)=%d\n', pout(loop))

	% compare two hmms
	if loop>1
		if abs((pout(loop)-pout(loop-1))/pout(loop)) < 5e-5
			fprintf('convergence!\n');
			return
		end
	end
end

disp('convergence not reached for 40 iterations, quit');
