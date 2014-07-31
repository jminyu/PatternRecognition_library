disp('1�ܰ�:' )
disp('�����ν��ĺ��� ����� ������ ���� ��ó��')
for i=1:5
	fname = sprintf('%dr.wav',i);
	x = wavread(fname);
	x = filter([1 -0.9375], 1, x);
	m = melcepst(x,16000,'M',12,24,256,80);
	ref(i).mfcc = m;
end

disp('����� ������ ���� Ư¡����...')
for i=1:5
	fname = sprintf('%dt.wav',i);
	x = wavread(fname);
	x = filter([1 -0.9375], 1, x);
	m = melcepst(x,16000,'M',12,24,256,80);
	test(i).mfcc = m;
end

disp('2�ܰ�: DTW ��Ī...')
dist = zeros(5,5);
for i=1:5
for j=1:5
	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc);
end
end


disp('3�ܰ�: ���...')

dist 
for i=1:5
	[d,j] = min(dist(i,:));
	fprintf('���� ���� %d ===> %d �� �ν�\n', i, j);
end