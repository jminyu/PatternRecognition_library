disp('1단계:' )
disp('음성인식후보와 시험용 음성에 대한 전처리')
for i=1:5
	fname = sprintf('%dr.wav',i);
	x = wavread(fname);
	x = filter([1 -0.9375], 1, x);
	m = melcepst(x,16000,'M',12,24,256,80);
	ref(i).mfcc = m;
end

disp('시험용 음성에 대한 특징추출...')
for i=1:5
	fname = sprintf('%dt.wav',i);
	x = wavread(fname);
	x = filter([1 -0.9375], 1, x);
	m = melcepst(x,16000,'M',12,24,256,80);
	test(i).mfcc = m;
end

disp('2단계: DTW 매칭...')
dist = zeros(5,5);
for i=1:5
for j=1:5
	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc);
end
end


disp('3단계: 결과...')

dist 
for i=1:5
	[d,j] = min(dist(i,:));
	fprintf('시험 음성 %d ===> %d 로 인식\n', i, j);
end