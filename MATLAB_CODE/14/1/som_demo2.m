clear;clf;
% �ʱ� ���� ����ġ ����
num_rows = 15;
num_cols = 15;
a = 0.20;	%  �̿� ũ��(G)�� �н���(eta)�� ���Ҹ� ���� ����

% �ʱ� ����ġ �� ����
% ����: �� ������ 2���� �����͸� ��ķ� �ٷ��� �ʰ� ���Ҽ��� �̿��Ͽ� ǥ���Ͽ���
dx = 0.1;
m = dx*(1-2*rand(num_rows,num_cols)) + dx*(1i-2i*rand(num_rows,num_cols));

for cycle=1:5000,

	eta = cycle^(-a);		% �н��� (�󸶳� ���� ��带 ������ ���ΰ��� ����)
	G = 0.5 + 10*cycle^(-a);% ����þ� �� ���� �Ķ����
	
    x = 1-2*rand;
	y = 1-2*rand;

    inp = x + y*i;		% �Է� ������(���Ҽ��� 2���� ǥ��)

	% ���� ��带 ã�´�
    % �Ÿ� ����� �����ϰ�
	dist_mat = (real(m)-real(inp)).^2 + (imag(m)-imag(inp)).^2;
    % dist_mat�� ���ͷ� �ٲٰ�, �ּ� ������ ã�´�.  
    [win_rows,win_cols] = find(dist_mat==min(dist_mat(:)));
	rand_idx = ceil(length(win_rows)*rand);	
	% �̵� �����߿��� ������ �ϳ��������Ѵ� 
    win_row = win_rows(rand_idx);
	win_col = win_cols(rand_idx);

	% ���ڿ��� ���ڷ� ���� �Ÿ��� ����ϰ� 
	[col_idx,row_idx] = meshgrid(1:num_cols,1:num_rows);
	% �ε��� ����� �����	
	grid_dist = abs(row_idx-win_row) + abs(col_idx-win_col);
	
	% �� ��忡 ���Ͽ� �̿��� ũ�⸦ ��Ÿ���� ����þ� Ŀ���� ����Ѵ�. 
	f = eta * exp(-(grid_dist/G).^2);

	% Ư¡ ������ �÷�
	if max(cycle == [1 10 30 50 100 200 400 600 800 1000 3000 5000]), % �� �ܰ踶�� �÷�
		figure(1);
		if (cycle>1),delete(h);end;	% ���� �÷��� �����
		hold on;
		h=plot(real(m),imag(m),'w-',real(m'),-imag(m'),'w-');
		% ���ο� SOFM ���ڸ� �׸���. 
		hold off;
		title(['�Ʒ� Ƚ��:' num2str(cycle) ...
       			',  �̿��� ũ��:' num2str(G) ...
       			',  �н���:' num2str(eta) ]); 
		drawnow;
    end;
	%%% ��� �̵� 
	m = m + f.*(inp-m);
end;