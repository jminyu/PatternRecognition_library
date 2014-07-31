function [h1, h2] = ox(p1, p2, varargin)

% [h1,h2] = pmx(p1, p2, crosspoint1, crosspoint2)
% [h1,h2] = pmx(p1, p2)
%
% p1 �� p2�� ���� ���� ����(OX) ���� 
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

lgh = length(p1); 
h1 = zeros(1,lgh);  % �ڼ�1
for i=c1+1:c2
   h1(i) = p1(i);   
end
h2 = zeros(1,lgh);  % �ڼ�2
for i=c1+1:c2
   h2(i) = p2(i);   
end

temp1 = zeros(1,lgh);
temp2 = zeros(1,lgh-(c2-c1)-1);
%�ڼ�1�� ���� ó��----------------------------------------------------
%���θ��� �ι�° ���������� ���õ��� ������ �����Ͽ� ����
for i=c2+1:lgh
   temp1(i-c2) = p2(i);   
end
for i=1:c2
   temp1(lgh-c2+i) = p2(i);   
end

for i=c1+1:c2
   j=temp1==h1(i);
   temp1(j)=0;
end
%ù�ڼտ� �̹� �ִ°��� ����
idx = 1; 
for i=1:lgh
   if temp1(i) ~= 0
      temp2(idx) = temp1(i);
      idx = idx + 1;
   end
end

%���� ����
idx = 1;
for i=c2+1:lgh
   h1(i) = temp2(idx);
   idx = idx + 1;
end
for i=1:c1
   h1(i) = temp2(idx);
   idx = idx + 1;
end
%�ڼ�2�� ���� ó��----------------------------------------------------
%���θ��� �ι�° ���������� ���õ��� ������ �����Ͽ� ����
for i=c2+1:lgh
   temp1(i-c2) = p1(i);   
end
for i=1:c2
   temp1(lgh-c2+i) = p1(i);   
end

for i=c1+1:c2
   j=temp1==h2(i);
   temp1(j)=0;
end
%ù�ڼտ� �̹� �ִ°��� ����
idx = 1; 
for i=1:lgh
   if temp1(i) ~= 0
      temp2(idx) = temp1(i);
      idx = idx + 1;
   end
end

%���� ����
idx = 1;
for i=c2+1:lgh
   h2(i) = temp2(idx);
   idx = idx + 1;
end
for i=1:c1
   h2(i) = temp2(idx);
   idx = idx + 1;
end
