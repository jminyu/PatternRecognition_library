hold on
grid on;
% �Է� ���� ������ �����
X = zeros(1000,2);
for i = 1:1000
    for j = 1:2
        X(i,j) = randn(1,1)+1;
    end
end
% LBG VQ ����
[CBout,esq,j] = kmeanlbg(X,7);
scatter(CBout(:,1),CBout(:,2),'b','filled');
CBout