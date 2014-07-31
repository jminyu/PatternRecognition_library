function [lcscount, lcs_path, lcs_str, lcstable] = lcs(a, b)
%  LCS Longest (maximum) common subsequence
%	용법:
%	[count, lcs_path, lcs_str, lcstable] = lcsm(a, b)
%	a: 입력 문자열 1
%	b: 입력 문자열 2
%	count: LCS의 개수
%	lcs_path: lcs 테이블상에서의 동적계획법의 통한 최적 패스
%	lcs_str: LCS 문자열
%	lcstable: 동적계획법이 적용된LCS 테이블

if nargin == 0, return; end

a = a(:).';
b = b(:).';
m = length(a);
n = length(b);
lcstable = zeros(m+1, n+1);
prevx = zeros(m+1, n+1);
prevy = zeros(m+1, n+1);
% 동적계획법을 사용하여 LCS 찾기
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

% 초기 조건 제거
lcstable = lcstable(2:end, 2:end);
prevx = prevx(2:end, 2:end)-1;
prevy = prevy(2:end, 2:end)-1;

% LCS 문자열의 길이 리턴
lcscount = lcstable(m, n);

% 동적 계획법의 최적 패스 리턴
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

% LCS 문자열 리턴
if nargout > 2,	
	temp = lcstable((lcs_path(:,2)-1)*m+lcs_path(:,1));  % 패스를 따라 LCS 카운트
	temp = [0; temp];
	index = find(diff(temp));
	lcs_str = a(lcs_path(index,1));
end