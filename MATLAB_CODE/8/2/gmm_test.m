clear all
% 1단계 
% X1 : 평균이 [1,1], 공분산이 [0.3 0 ;0 0.2]인 분포를 이루는 데이터 100개 생성
muvec = [1 1];
covmat = [0.3 0; 0 0.2];
X1 = generate_gauss(muvec,covmat,100);
% X2 : 평균이 [5,2], 공분산이 [0.4 0 ;0 0.4]인 분포를 이루는 데이터 100개 생성
muvec = [5 2];
covmat = [0.4 0; 0 0.4];
X2 = generate_gauss(muvec,covmat,100);
% X3 : 평균이 [1,5], 공분산이 [0.3 0 ;0 0.2]인 분포를 이루는 데이터 100개 생성
muvec = [1 5];
covmat = [0.3 0; 0 0.2];
X3 = generate_gauss(muvec,covmat,100);

scatter(X1(1,:),X1(2,:),'b.');
hold on 
scatter(X2(1,:),X2(2,:),'r.');
scatter(X3(1,:),X3(2,:),'k.');

display('3개의 클래스에 대한 데이터 생성 완료. 엔터키를 누르면 다음 단계로!');
pause 

% 2단계
% X1 데이터에 대한 GMM학습을 위한 초기값을 생성(혼합수: 3)
[mus, sigmas, weights] = initParams(2,3);
% X1 데이터에 대한 학습 시작
[mus, sigmas, weights] = trainGMM(X1, mus, sigmas, weights, 0.0001, 100, 'diagcov');
% X1 데이터에 학습이 끝나면 저장
X1_mus = mus;
X1_sigmas = sigmas;
X1_weights = weights;
% X1 데이터에 대한 GMM학습 완료

% X2 데이터에 대한 GMM학습을 위한 초기값을 생성(혼합수: 3)
[mus, sigmas, weights] = initParams(2,3);
% X1 데이터에 대한 학습 시작
[mus, sigmas, weights] = trainGMM(X2, mus, sigmas, weights, 0.0001, 100, 'diagcov');
% X1 데이터에 학습이 끝나면 저장
X2_mus = mus;
X2_sigmas = sigmas;
X2_weights = weights;
% X2 데이터에 대한 GMM학습 완료

% X3 데이터에 대한 GMM학습을 위한 초기값을 생성(혼합수: 3)
[mus, sigmas, weights] = initParams(2,3);
% X3 데이터에 대한 학습 시작
[mus, sigmas, weights] = trainGMM(X3, mus, sigmas, weights, 0.0001, 100, 'diagcov');
% X3 데이터에 학습이 끝나면 저장
X3_mus = mus;
X3_sigmas = sigmas;
X3_weights = weights;
% X3 데이터에 대한 GMM학습 완료
display('3개의 클래스에 대한 학습 완료. 엔터키를 누르면 다음 단계로!');
pause

% 3 단계
% 추정된 가우시안 분포를 플롯 
% X1 데이터에 대한 1번째 혼합수에 대한 플롯 
m = X1_mus(:,1)';
s = zeros(2,2);
s(1,1) = X1_sigmas(1,1);
s(2,2) = X1_sigmas(2,1);
plotgaus(m,s);
% X1 데이터에 대한 2번째 혼합수에 대한 플롯 
m = X1_mus(:,2)';
s = zeros(2,2);
s(1,1) = X1_sigmas(1,2);
s(2,2) = X1_sigmas(2,2);
plotgaus(m,s);
% X1 데이터에 대한 3번째 혼합수에 대한 플롯 
m = X1_mus(:,3);
m = m';
s = zeros(2,2);
s(1,1) = X1_sigmas(1,3);
s(2,2) = X1_sigmas(2,3);
plotgaus(m,s);

% X2 데이터에 대한 1번째 혼합수에 대한 플롯 
m = X2_mus(:,1)';
s = zeros(2,2);
s(1,1) = X2_sigmas(1,1);
s(2,2) = X2_sigmas(2,1);
plotgaus(m,s);
% X2 데이터에 대한 2번째 혼합수에 대한 플롯 
m = X2_mus(:,2)';
s = zeros(2,2);
s(1,1) = X2_sigmas(1,2);
s(2,2) = X2_sigmas(2,2);
plotgaus(m,s);
% X2 데이터에 대한 3번째 혼합수에 대한 플롯 
m = X2_mus(:,3);
m = m';
s = zeros(2,2);
s(1,1) = X2_sigmas(1,3);
s(2,2) = X2_sigmas(2,3);
plotgaus(m,s);

% X3 데이터에 대한 1번째 혼합수에 대한 플롯 
m = X3_mus(:,1)';
s = zeros(2,2);
s(1,1) = X3_sigmas(1,1);
s(2,2) = X3_sigmas(2,1);
plotgaus(m,s);
% X3 데이터에 대한 2번째 혼합수에 대한 플롯 
m = X3_mus(:,2)';
s = zeros(2,2);
s(1,1) = X3_sigmas(1,2);
s(2,2) = X3_sigmas(2,2);
plotgaus(m,s);
% X3 데이터에 대한 3번째 혼합수에 대한 플롯 
m = X3_mus(:,3);
m = m';
s = zeros(2,2);
s(1,1) = X3_sigmas(1,3);
s(2,2) = X3_sigmas(2,3);
plotgaus(m,s);
hold on 
display('3개의 클래스에 대한 가우시안 혼합 모델링 플롯 완료. 엔터키를 누르면 다음 단계로!');
pause 

% 4 단계
% 각 클래스별 학습 결과를 리스트에 셀을 이용 저장
mulist = {X1_mus X2_mus X3_mus};
sigmaslist = {X1_sigmas X2_sigmas X3_sigmas};
weightslist = {X1_weights X2_weights X3_weights};
display('3개의 클래스에 대한 가우시안 혼합 모델링 파라미터 저장 완료. 엔터키를 누르면 다음 단계로!');
pause 

% 5 단계
% 시험 데이터 1
test=[1.2; 1.3];
%이제 인식해보자  
classes = classify_GMM(test,mulist, sigmaslist, weightslist);
scatter(test(1,:),test(2,:),'kp');
display('시험 데이터1 에 대한 인식 결과, 다음 데이터를 인식 할려면 엔터키를 누르시요');
classes
pause 
% 시험 데이터 2
%test=[1.2 4.1 1.2 2.5 4.2; 1.3 2.1 5.4 2.2 1.8];
test=[4.1; 2.1];
%이제 인식해보자  
classes = classify_GMM(test,mulist, sigmaslist, weightslist);
scatter(test(1,:),test(2,:),'kp');
display('시험 데이터1 에 대한 인식 결과, 다음 데이터를 인식 할려면 엔터키를 누르시요');
classes

% 시험 데이터 3
test=[2.1; 4.1];
%이제 인식해보자  
classes = classify_GMM(test,mulist, sigmaslist, weightslist);
scatter(test(1,:),test(2,:),'kp');
display('시험 데이터3 에 대한 인식 결과, 끝');
classes


