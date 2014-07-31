clear all

traindata = cell(1,10);
for i=0:9
    temp = cell(1,3);%3¸í ÇÐ½À 
    for j=1:3
     fname = sprintf('%d%da.wav',i,j);
     x = wavread(fname);
     temp{1,j}=x';
   end
   traindata{1,i+1} = temp;
end

hmm = cell(1,10);
% train
for i = 1:length(traindata)
	sample = [];
	for k = 1:length(traindata{i})
		x = filter([1 -0.9375], 1, traindata{i}{k});
		sample(k).data = melcepst(x,16000,'M',12,24,256,80);
	end
	hmm{i}=train(sample,[3 3 3 3]);
end

% recognize
for i = 1:10
	fname = sprintf('%d1a.wav',i-1);
	x = wavread(fname);
	x = filter([1 -0.9375], 1, x);
	m = melcepst(x,16000,'M',12,24,256,80);
	for j = 1:10
		pout(j) = viterbi(hmm{j}, m);
	end
	[d,n] = max(pout);

    fprintf('word number %d is recognized as %d\n', i-1,n)
end