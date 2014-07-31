% �ʱ� �ڵ��
CBin = [1,1; -1,1; -1,-1; 1, -1; 0,1; 0,-1; 0,0];
hold on
grid on;
scatter(CBin(:,1),CBin(:,2),'r','filled');  %�ʱ� �ڵ�� �����ֱ�  
% �Է� ���� ������ �����
X = zeros(1000,2);
for i = 1:1000
    for j = 1:2
        X(i,j) = randn(1,1)+1;
    end
end

delta = 0.01;
% LBG VQ ����
CBout = kmeans1(CBin, X, delta); 
scatter(CBout(:,1),CBout(:,2),'b','filled');