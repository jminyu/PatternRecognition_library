function [h1, h2] = pmx(p1, p2, varargin)
% [h1,h2] = pmx(p1, p2, crosspoint1, crosspoint2)
% [h1,h2] = pmx(p1, p2)
%
% p1와 p2의 부분 사상 교배(PMX) 구현  
% 교배점이 주어지지 않으면 임의로 선택
% 교배점 crosspoint1는 교배점 crosspoint2보다 작아야 함.

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
  j = find(h2==p1(i));%h2에서 p1(i)의 값이 있는 위치을 찾아서
  tmp = h2(j);%그 곳의 값을 tmp에 저장하여
  h2(j) = h2(i);%위치를 바꾼다.
  h2(i) = tmp;
  j = find(h1==p2(i));%h1에서 p2(i)의 값이 있는 위치를 찾아서
  tmp = h1(j);%그 곳의 값을 tmp에 저장하여
  h1(j) = h1(i);%위치를 바꾼다.
  h1(i) = tmp;
end
