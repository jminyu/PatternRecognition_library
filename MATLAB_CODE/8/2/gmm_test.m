clear all
% 1�ܰ� 
% X1 : ����� [1,1], ���л��� [0.3 0 ;0 0.2]�� ������ �̷�� ������ 100�� ����
muvec = [1 1];
covmat = [0.3 0; 0 0.2];
X1 = generate_gauss(muvec,covmat,100);
% X2 : ����� [5,2], ���л��� [0.4 0 ;0 0.4]�� ������ �̷�� ������ 100�� ����
muvec = [5 2];
covmat = [0.4 0; 0 0.4];
X2 = generate_gauss(muvec,covmat,100);
% X3 : ����� [1,5], ���л��� [0.3 0 ;0 0.2]�� ������ �̷�� ������ 100�� ����
muvec = [1 5];
covmat = [0.3 0; 0 0.2];
X3 = generate_gauss(muvec,covmat,100);

scatter(X1(1,:),X1(2,:),'b.');
hold on 
scatter(X2(1,:),X2(2,:),'r.');
scatter(X3(1,:),X3(2,:),'k.');

display('3���� Ŭ������ ���� ������ ���� �Ϸ�. ����Ű�� ������ ���� �ܰ��!');
pause 

% 2�ܰ�
% X1 �����Ϳ� ���� GMM�н��� ���� �ʱⰪ�� ����(ȥ�ռ�: 3)
[mus, sigmas, weights] = initParams(2,3);
% X1 �����Ϳ� ���� �н� ����
[mus, sigmas, weights] = trainGMM(X1, mus, sigmas, weights, 0.0001, 100, 'diagcov');
% X1 �����Ϳ� �н��� ������ ����
X1_mus = mus;
X1_sigmas = sigmas;
X1_weights = weights;
% X1 �����Ϳ� ���� GMM�н� �Ϸ�

% X2 �����Ϳ� ���� GMM�н��� ���� �ʱⰪ�� ����(ȥ�ռ�: 3)
[mus, sigmas, weights] = initParams(2,3);
% X1 �����Ϳ� ���� �н� ����
[mus, sigmas, weights] = trainGMM(X2, mus, sigmas, weights, 0.0001, 100, 'diagcov');
% X1 �����Ϳ� �н��� ������ ����
X2_mus = mus;
X2_sigmas = sigmas;
X2_weights = weights;
% X2 �����Ϳ� ���� GMM�н� �Ϸ�

% X3 �����Ϳ� ���� GMM�н��� ���� �ʱⰪ�� ����(ȥ�ռ�: 3)
[mus, sigmas, weights] = initParams(2,3);
% X3 �����Ϳ� ���� �н� ����
[mus, sigmas, weights] = trainGMM(X3, mus, sigmas, weights, 0.0001, 100, 'diagcov');
% X3 �����Ϳ� �н��� ������ ����
X3_mus = mus;
X3_sigmas = sigmas;
X3_weights = weights;
% X3 �����Ϳ� ���� GMM�н� �Ϸ�
display('3���� Ŭ������ ���� �н� �Ϸ�. ����Ű�� ������ ���� �ܰ��!');
pause

% 3 �ܰ�
% ������ ����þ� ������ �÷� 
% X1 �����Ϳ� ���� 1��° ȥ�ռ��� ���� �÷� 
m = X1_mus(:,1)';
s = zeros(2,2);
s(1,1) = X1_sigmas(1,1);
s(2,2) = X1_sigmas(2,1);
plotgaus(m,s);
% X1 �����Ϳ� ���� 2��° ȥ�ռ��� ���� �÷� 
m = X1_mus(:,2)';
s = zeros(2,2);
s(1,1) = X1_sigmas(1,2);
s(2,2) = X1_sigmas(2,2);
plotgaus(m,s);
% X1 �����Ϳ� ���� 3��° ȥ�ռ��� ���� �÷� 
m = X1_mus(:,3);
m = m';
s = zeros(2,2);
s(1,1) = X1_sigmas(1,3);
s(2,2) = X1_sigmas(2,3);
plotgaus(m,s);

% X2 �����Ϳ� ���� 1��° ȥ�ռ��� ���� �÷� 
m = X2_mus(:,1)';
s = zeros(2,2);
s(1,1) = X2_sigmas(1,1);
s(2,2) = X2_sigmas(2,1);
plotgaus(m,s);
% X2 �����Ϳ� ���� 2��° ȥ�ռ��� ���� �÷� 
m = X2_mus(:,2)';
s = zeros(2,2);
s(1,1) = X2_sigmas(1,2);
s(2,2) = X2_sigmas(2,2);
plotgaus(m,s);
% X2 �����Ϳ� ���� 3��° ȥ�ռ��� ���� �÷� 
m = X2_mus(:,3);
m = m';
s = zeros(2,2);
s(1,1) = X2_sigmas(1,3);
s(2,2) = X2_sigmas(2,3);
plotgaus(m,s);

% X3 �����Ϳ� ���� 1��° ȥ�ռ��� ���� �÷� 
m = X3_mus(:,1)';
s = zeros(2,2);
s(1,1) = X3_sigmas(1,1);
s(2,2) = X3_sigmas(2,1);
plotgaus(m,s);
% X3 �����Ϳ� ���� 2��° ȥ�ռ��� ���� �÷� 
m = X3_mus(:,2)';
s = zeros(2,2);
s(1,1) = X3_sigmas(1,2);
s(2,2) = X3_sigmas(2,2);
plotgaus(m,s);
% X3 �����Ϳ� ���� 3��° ȥ�ռ��� ���� �÷� 
m = X3_mus(:,3);
m = m';
s = zeros(2,2);
s(1,1) = X3_sigmas(1,3);
s(2,2) = X3_sigmas(2,3);
plotgaus(m,s);
hold on 
display('3���� Ŭ������ ���� ����þ� ȥ�� �𵨸� �÷� �Ϸ�. ����Ű�� ������ ���� �ܰ��!');
pause 

% 4 �ܰ�
% �� Ŭ������ �н� ����� ����Ʈ�� ���� �̿� ����
mulist = {X1_mus X2_mus X3_mus};
sigmaslist = {X1_sigmas X2_sigmas X3_sigmas};
weightslist = {X1_weights X2_weights X3_weights};
display('3���� Ŭ������ ���� ����þ� ȥ�� �𵨸� �Ķ���� ���� �Ϸ�. ����Ű�� ������ ���� �ܰ��!');
pause 

% 5 �ܰ�
% ���� ������ 1
test=[1.2; 1.3];
%���� �ν��غ���  
classes = classify_GMM(test,mulist, sigmaslist, weightslist);
scatter(test(1,:),test(2,:),'kp');
display('���� ������1 �� ���� �ν� ���, ���� �����͸� �ν� �ҷ��� ����Ű�� �����ÿ�');
classes
pause 
% ���� ������ 2
%test=[1.2 4.1 1.2 2.5 4.2; 1.3 2.1 5.4 2.2 1.8];
test=[4.1; 2.1];
%���� �ν��غ���  
classes = classify_GMM(test,mulist, sigmaslist, weightslist);
scatter(test(1,:),test(2,:),'kp');
display('���� ������1 �� ���� �ν� ���, ���� �����͸� �ν� �ҷ��� ����Ű�� �����ÿ�');
classes

% ���� ������ 3
test=[2.1; 4.1];
%���� �ν��غ���  
classes = classify_GMM(test,mulist, sigmaslist, weightslist);
scatter(test(1,:),test(2,:),'kp');
display('���� ������3 �� ���� �ν� ���, ��');
classes


