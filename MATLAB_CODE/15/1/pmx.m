function [h1, h2] = pmx(p1, p2, varargin)
% [h1,h2] = pmx(p1, p2, crosspoint1, crosspoint2)
% [h1,h2] = pmx(p1, p2)
%
% p1�� p2�� �κ� ��� ����(PMX) ����  
% �������� �־����� ������ ���Ƿ� ����
% ������ crosspoint1�� ������ crosspoint2���� �۾ƾ� ��.

if length(varargin) >= 2
  % if given, accept crosspoints
  c1 = varargin{1};
  c2 = varargin{2};
else
  % if not given, generate crosspoints
  c1 = floor(rand*(length(p1)-1))+1;
  c2 = floor(rand*(length(p2)-1));
  if c2 >= c1
    c2 = c2 + 1;
  else
    tmp = c1;
    c1 = c2;
    c2 = tmp;
  end
end

if c2 <= c1
  error('crossover points are incorrect (c2<=c1)')
end

h1 = p1;  % child1
h2 = p2;  % child2

for i=c1+1:c2
  j = find(h2==p1(i));%h2���� p1(i)�� ���� �ִ� ��ġ�� ã�Ƽ�
  tmp = h2(j);%�� ���� ���� tmp�� �����Ͽ�
  h2(j) = h2(i);%��ġ�� �ٲ۴�.
  h2(i) = tmp;
  j = find(h1==p2(i));%h1���� p2(i)�� ���� �ִ� ��ġ�� ã�Ƽ�
  tmp = h1(j);%�� ���� ���� tmp�� �����Ͽ�
  h1(j) = h1(i);%��ġ�� �ٲ۴�.
  h1(i) = tmp;
end
