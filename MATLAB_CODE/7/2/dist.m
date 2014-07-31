function y = dist(x1,x2)
% 두점간의 거리 계산 
K = length(x1);
y = 0;
for i = 1:K
    y = y + (x1(i)-x2(i))^2;
end
y = sqrt(y);