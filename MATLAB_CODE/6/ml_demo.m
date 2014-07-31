% ������ ������ ������ ������ X1, X2�� �����ϰ� �׸����� �����ش�.
N = 100;mu_1 = [380 400]; 
sigma_1 = [300 30; 20 200];
X1 = randn(N,2) * sqrtm(sigma_1) + repmat(mu_1,N,1);
        
mu_2 = [430 350]; 
sigma_2 = [400 100; 50 90];
X2 = randn(N,2) * sqrtm(sigma_2) + repmat(mu_2,N,1);

z=[1 0 0]; %Red
scatter(X1(:,1),X1(:,2), 3,z);

hold on

z=[0 1 0];%Green
scatter(X2(:,1),X2(:,2), 3,z);

plotgaus(mu_1, sigma_1, 'R');
plotgaus(mu_2, sigma_2, 'G');

% ML������ �̿��Ͽ� �����Ϳ� ���� ��հ� ���л��� �����Ѵ�. 
model1 = mlgauss(X1',1); % 1�� �������л��� ���� 
model2 = mlgauss(X2',1); % 1�� �������л��� ����

plotgaus(model1.Mu', model1.C, 'B');
plotgaus(model2.Mu', model2.C, 'B');

% ���� ������ �����͸� �з��غ���
model.Mu = [model1.Mu model2.Mu];
model.C = zeros(2,2,2);
model.C(:,:,1) = model1.C;
model.C(:,:,2) = model2.C;
model.P = [1 1]/2; %���� Ȯ���� ����(1/2) 

% ������ �� ������ ����
T = [420 365]';
z=[0 0 0]; % Color Black
scatter(T(1,:),T(2,:), 3,z, 'filled');
[y, like]= bayescls(T, model);
y
like

pause
% ������ �� ������ ����
T = [430 370]'; %360 380]';
z=[0 0 0]; % Color Black
scatter(T(1,:),T(2,:), 3,z, 'filled');
[y, like]= bayescls(T, model);
y
like

pause
% ������ �� ������ ����
T = [390 380]';
z=[0 0 0]; % Color Black
scatter(T(1,:),T(2,:), 3,z, 'filled');
[y, like]= bayescls(T, model);
y
like
