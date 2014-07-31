str1 = 'GAATTCAGTTA';
str2 = 'GGATCGA';
m = length(str1);
n = length(str2);
figure;
%[xx, yy] = meshgrid(1:m, 1:n);
%plot(xx(:), yy(:), '.');
axis([0 m+1 0 n+1]);
box on;
set(gca, 'xtick', 1:m);
set(gca, 'ytick', 1:n);
set(gca, 'xticklabel', char(double(str1)'));
set(gca, 'yticklabel', char(double(str2)'));

% LCS  시작
[count, lcs_path, lcs_str, lcstable] = lcs(str1, str2);
xlabel(['String1 = ', str1]);
ylabel(['String2 = ', str2]);
title(['LCS table and LCS path; with LCS = ', lcs_str]);

% LCS 테이블 플롯
for i = 1:m,
	for j = 1:n,
		text(i, j, int2str(lcstable(i,j)), 'hori', 'center');
	end
end

% LCS 패스 플롯
for i = 1:size(lcs_path,1)-1,
	line(lcs_path(i:i+1, 1), lcs_path(i:i+1, 2));
end

% 매칭된 요소에 동그라미 그리기
temp = lcstable((lcs_path(:,2)-1)*m+lcs_path(:,1)); % 패스를 따라 LCS 카운팅
temp = [0; temp];
index = find(diff(temp));
match_point = lcs_path(index, :);
line(match_point(:,1), match_point(:, 2), ...
	'marker', 'o', 'markersize', 15, 'color', 'r', 'linestyle', 'none');