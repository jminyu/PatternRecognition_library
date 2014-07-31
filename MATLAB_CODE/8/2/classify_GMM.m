function classes = classify_GMM(X, mulist, sigmalist, weightlist);

% 데이터 집합 X에서 각 벡터에 대한 베이즈의 분류를 수행 
% 이 분류를 통하여 GMM모델이 지정하는 클래스 중에서 하나로 이 벡터를 할당
%
% 입력 인자:
% X: d*numpoints 데이터 행렬
% mulist : 각 클래스에 대한 MUS를 가지고 있는 리스트 
% sigmalist : 각 클래스에 대한 SIGMAS를 가지고 있는 리스트
% weightlist : 각 클래스에 대한 WEIGHTS를 가지고 있는 리스트 
% 
% 출력 인자 :
% classes : 각 데이터 점에 할당된 클래스를 가지고 있는 열 벡터 

  [d,numpoints] = size(X);
  
  %if (is_list(mulist) & is_list(sigmalist) & is_list(weightlist)) == 0
  %   error('classify_GMM(X, mulist, sigmalist, weightlist) : lists should be lists!');
  %end    
      
  numclasses = length(mulist);
  
  %if (length(weightlist) == length(sigmalist) & length(sigmalist) == numclasses)
  %   error('List lengths inconsistent!');
  %end    
  
  bestloglike = loglikeGMM(X,mulist{:,1},sigmalist{:,1},weightlist{:,1});
  classes = ones(1,numpoints);
  for c = 2:numclasses
    newloglike = loglikeGMM(X,mulist{:,c},sigmalist{:,c},weightlist{:,c});
    better_idx = find(newloglike > bestloglike);
    bestloglike(better_idx) = newloglike(better_idx);
    classes(better_idx) = c;
  end
