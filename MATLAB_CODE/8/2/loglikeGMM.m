function [loglike, pmat] = loglikeGMM(X, mus, sigmas, weights);

% 대각 가우시안의 믹스쳐에 대한 X의 각 데이터 벡터의 로그 우도를 리턴한다. 
% 또한 각 믹스쳐 성분과 데이터 점에 대한 개별 스코어인 ( p(x_n|m)c_m )를
% 포함하고 있는 M*numpoints 행렬을 리턴한다.
%
% 입력 인자 :
% X : 행이 d-차원인 특징 벡터들인 데이터 행렬이다.
% mus : d*M 행렬로 그 행은 믹스쳐 성분에 대한 평균 벡터.
% sigmas : d*M 행렬로 그 행은 믹스쳐 혼합 성분에 대한 분산 벡터.
% weights : M-차원 벡터로 믹스쳐 가중치.
%
% 출력 인자 :
% loglike : 로그-우도값의 열 벡터.
% pmat : 위에서 설명한것과 같은 스코어된 믹스쳐 성분의 행렬.

  
  [d,numpoints] = size(X);
  M = length(weights);
  if (abs(sum(weights) - 1) < 0.01) == 0
     error('trainGMM: Weights should sum to 1!');
  end
 
  if ((size(mus) == [d,M]) & (size(sigmas) == [d,M])) == 0
     error('Incompatible dimensions!');
  end
 
  for n = 1:numpoints
    for m = 1:M
      pmat(m,n) = weights(m)*gauss_pdf(X(:,n),mus(:,m),diag(sigmas(:,m)));
    end
  end

  if M > 1
    loglike = log(sum(pmat));
  else
    loglike = log(pmat);
  end
