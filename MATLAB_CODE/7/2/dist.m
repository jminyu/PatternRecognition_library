function y = dist(x1,x2)
% �������� �Ÿ� ��� 
K = length(x1);
y = 0;
for i = 1:K
    y = y + (x1(i)-x2(i))^2;
end
y = sqrt(y);