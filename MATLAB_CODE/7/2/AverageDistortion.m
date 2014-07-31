function y = AverageDistortion (X,C)
% ��տְ� ��� 
% �Է� ���� :
%  X:  �н� ���� ��, M x K ���, �� ���� K������ �н������̴�
% C:  �ڵ��, N x K ���, �� ���� K������ �ڵ�����̴�. 
% ��� ���� :
%  y:  �н����� ��� �ְ�� �ڵ��
[M,K] = size(X);
[N,K] = size(C);
D = 0;
 
for i = 1:M
    min = inf;
    for j = 1:N
        if dist(X(i,:),C(j,:)) < min
            min = dist(X(i,:),C(j,:));
        end
    end
    D = D + min;
end
y = D/M;