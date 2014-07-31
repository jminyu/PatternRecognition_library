% [mus, sigmas, weights] = trainGMM(X, mus, sigmas, weights, threshold, maxiterations, modeltype);
% ������ ��� X�󿡼� [mus, sigmas, weights]�� �Ķ���Ϳ� ���Ͽ� ������ GMM��  
% EM �˰����� �̿��� �н��� �α׿쵵�� THRESHOLD ������ ���ų� 
% MAXITERATIONS �ݺ� �޼��� �� �� ���� ����.
% ȥ�� ������ ���л꿡 ���� ���� ���´� MODELTYPE���� 
% �����ϵ� ���� ��� Ȥ�� �밢 ��ķ� ���� ����. 
% (���� ���л������� Ȯ���ҷ��� sigmas�� ���Ͱ� �ƴ϶� ��ķ� �������߸� �Ѵ�.) 
%
% �Է� ���� :
% X�� ���� d������ Ư¡ ���� ������ ���.
% mus : d*M ��ķ� �� ���� �ͽ��� ���п� ���� ��� ����.
% sigmas : d*M ��ķ� �� ���� �ͽ��� ȥ�� ���п� ���� �л� ����.
% weights : M-���� ���ͷ� ȥ�� ����ġ.
% modeltype : 'scalarcov' Ȥ�� 'diagcov' ���ڿ�.
% ��� ���� : 

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
  plot(mus(1,:),mus(2,:),'bo') % �Ķ���� ����ȭ ������ �����ֱ� ���ؼ�
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
