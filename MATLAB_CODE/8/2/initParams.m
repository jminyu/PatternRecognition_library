% [mus, sigmas, weights] = initParams(d,M);
%
% trainGMM에서 사용될 적절한 파라메터 집합을 리턴한다. 
%
% 입력 인자 :
% d : 차원
% M : 믹스쳐 성분의 개수
%
% 출력 인자 : 
% mus -> means: "0" 주위에 랜덤하게 분포된다.  
% sigmas -> covariances: 모든 성분이 단위 공분산(1)인  행렬
% weights -> weights: 같은 성분 가중값

function [mus, sigmas, weights] = initParams(d,M);

  mus = rand(d,M)-0.5;
  sigmas = ones(d,M);
  weights = ones(M,1)/M;
