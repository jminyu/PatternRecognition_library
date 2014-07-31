% [mus, sigmas, weights] = trainGMM(X, mus, sigmas, weights, threshold, maxiterations, modeltype);
% 데이터 행렬 X상에서 [mus, sigmas, weights]인 파라미터에 의하여 정해진 GMM을  
% EM 알고리즘을 이용한 학습을 로그우도가 THRESHOLD 값보다 적거나 
% MAXITERATIONS 반복 햇수가 될 때 까지 수행.
% 혼합 성분의 공분산에 사용된 모델의 형태는 MODELTYPE에서 
% 스케일된 단위 행렬 혹은 대각 행렬로 지정 가능. 
% (완전 공분산으로의 확장할려면 sigmas가 벡터가 아니라 행렬로 정해져야만 한다.) 
%
% 입력 인자 :
% X는 행이 d차원인 특징 벡터 데이터 행렬.
% mus : d*M 행렬로 그 행은 믹스쳐 성분에 대한 평균 벡터.
% sigmas : d*M 행렬로 그 행은 믹스쳐 혼합 성분에 대한 분산 벡터.
% weights : M-차원 벡터로 혼합 가중치.
% modeltype : 'scalarcov' 혹은 'diagcov' 문자열.
% 출력 인자 : 

function [mus, sigmas, weights] = trainGMM(X, mus, sigmas, weights, threshold, maxiterations, modeltype);
  
% Check input params and get dimensions:
  [d,numpoints] = size(X);
  M = length(weights);
  if (abs(sum(weights) - 1) < 0.00001) == 0
     error('trainGMM: Weights should sum to 1!');
  end
  
  if (size(mus) == [d,M] & size(sigmas) == [d,M]) == 0
     error('trainGMM: Weights should sum to 1!');
  end
 
  if strcmp(modeltype,'scalarcov')
    xvars = zeros(1,numpoints);
  elseif strcmp(modeltype,'diagcov')
    xvarmat = zeros(d,numpoints);
  else
    error('Unknown model type!');
  end

% Plot data:
  % hold off
  % plot(X(1,:),X(2,:),'r.')
  % hold on

% Plot initial component centroids:
  %  plot(mus(1,:),mus(2,:),'bo')

% Calculate initial likelihoods:
  [loglikevec, pmat] = loglikeGMM(X, mus, sigmas, weights);
  loglike = sum(loglikevec);
  disp('Log likelihood at initialisation: '), disp(loglike);

% Iterate until convergence:
  for iteration = 1:maxiterations
    disp('Iteration:'),disp(iteration);

% E step: calculate posteriors under current parameter values:
    for n = 1:numpoints
      pmat(:,n) = pmat(:,n)/sum(pmat(:,n));
    end
    disp(pmat(:,1:5))

% M step: update parameter values to maximise posteriors:
    for m = 1:M;
% Mean update:
      psum = sum(pmat(m,:));
      mus(:,m) = (X * pmat(m,:)')/psum;
% Variance update:
      if strcmp(modeltype,'scalarcov')
	for n = 1:numpoints
          meansub = X(:,n)-mus(:,m);
          xvars(n) = meansub'*meansub;
	end
	sigmas(:,m) = ones(d,1)*(xvars * pmat(m,:)')/(d*psum);
      elseif strcmp(modeltype,'diagcov')
	for n = 1:numpoints
          meansub = X(:,n)-mus(:,m);
          xvarmat(:,n) = meansub.*meansub;
	end
	sigmas(:,m) = xvarmat * pmat(m,:)' / psum;       
      end
% Weight update:
      weights(m) = psum/numpoints;
    end

% Plot new component centroids:
  drawnow
  plot(mus(1,:),mus(2,:),'bo') % 파라미터 최적화 과정을 보여주기 위해서
  disp(weights)
  disp(mus)
  disp(sigmas)

% Calculate new log likelihood:
    [newloglikevec, pmat] = loglikeGMM(X, mus, sigmas, weights);
    newloglike = sum(newloglikevec);
    disp('Log likelihood: '), disp(newloglike);

% Test for convergence:
    if (newloglike < loglike)
      error('Log likelihood decreased!')
    end
    if ((newloglike - loglike)/numpoints < threshold)
      disp('Converged.')
      break;
    else 
      loglike = newloglike;
    end;

  end
  disp(' '),disp(' '),disp(' ')
