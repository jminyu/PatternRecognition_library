% 임의의 분포를 가지는 데이터 X1, X2를 생성하고 그림으로 보여준다.
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

% ML추정을 이용하여 데이터에 대한 평균과 공분산을 추정한다. 
model1 = mlgauss(X1',1); % 1은 완전공분산을 지정 
model2 = mlgauss(X2',1); % 1은 완전공분산을 지정

plotgaus(model1.Mu', model1.C, 'B');
plotgaus(model2.Mu', model2.C, 'B');

% 이제 임의의 데이터를 분류해보자
model.Mu = [model1.Mu model2.Mu];
model.C = zeros(2,2,2);
model.C(:,:,1) = model1.C;
model.C(:,:,2) = model2.C;
model.P = [1 1]/2; %사전 확률은 같다(1/2) 

% 임의의 한 테이터 설정
T = [420 365]';
z=[0 0 0]; % Color Black
scatter(T(1,:),T(2,:), 3,z, 'filled');
[y, like]= bayescls(T, model);
y
like

pause
% 임의의 한 테이터 설정
T = [430 370]'; %360 380]';
z=[0 0 0]; % Color Black
scatter(T(1,:),T(2,:), 3,z, 'filled');
[y, like]= bayescls(T, model);
y
like

pause
% 임의의 한 테이터 설정
T = [390 380]';
z=[0 0 0]; % Color Black
scatter(T(1,:),T(2,:), 3,z, 'filled');
[y, like]= bayescls(T, model);
y
like
