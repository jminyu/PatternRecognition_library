function [lcscount, lcs_path, lcs_str, lcstable] = lcs(a, b)
%  LCS Longest (maximum) common subsequence
%	���:
%	[count, lcs_path, lcs_str, lcstable] = lcsm(a, b)
%	a: �Է� ���ڿ� 1
%	b: �Է� ���ڿ� 2
%	count: LCS�� ����
%	lcs_path: lcs ���̺�󿡼��� ������ȹ���� ���� ���� �н�
%	lcs_str: LCS ���ڿ�
%	lcstable: ������ȹ���� �����LCS ���̺�

if nargin == 0, return; end

a = a(:).';
b = b(:).';
m = length(a);
n = length(b);
lcstable = zeros(m+1, n+1);
prevx = zeros(m+1, n+1);
prevy = zeros(m+1, n+1);
% ������ȹ���� ����Ͽ� LCS ã��
for i=1:m,
	for j = 1:n,
		if a(i)==b(j),
			lcstable(i+1,j+1) = lcstable(i,j)+1;
			prevx(i+1,j+1) = i;
			prevy(i+1,j+1) = j;
		elseif lcstable(i,j+1) > lcstable(i+1,j),
			lcstable(i+1,j+1) = lcstable(i,j+1);
			prevx(i+1,j+1) = i;
			prevy(i+1,j+1) = j+1;
		else
			lcstable(i+1,j+1) = lcstable(i+1,j);
			prevx(i+1,j+1) = i+1;
			prevy(i+1,j+1) = j;
		end 
	end
end

% �ʱ� ���� ����
lcstable = lcstable(2:end, 2:end);
prevx = prevx(2:end, 2:end)-1;
prevy = prevy(2:end, 2:end)-1;

% LCS ���ڿ��� ���� ����
lcscount = lcstable(m, n);

% ���� ��ȹ���� ���� �н� ����
if nargout > 1,
	now = [m, n];
	prev = [prevx(now(1), now(2)), prevy(now(1), now(2))];
	lcs_path = now;
	while all(prev>0),
		now = prev;
		prev = [prevx(now(1), now(2)), prevy(now(1), now(2))];
		lcs_path = [lcs_path; now];
	end 
	lcs_path = flipud(lcs_path);
end

% LCS ���ڿ� ����
if nargout > 2,	
	temp = lcstable((lcs_path(:,2)-1)*m+lcs_path(:,1));  % �н��� ���� LCS ī��Ʈ
	temp = [0; temp];
	index = find(diff(temp));
	lcs_str = a(lcs_path(index,1));
end