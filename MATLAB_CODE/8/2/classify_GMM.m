function classes = classify_GMM(X, mulist, sigmalist, weightlist);

% ������ ���� X���� �� ���Ϳ� ���� �������� �з��� ���� 
% �� �з��� ���Ͽ� GMM���� �����ϴ� Ŭ���� �߿��� �ϳ��� �� ���͸� �Ҵ�
%
% �Է� ����:
% X: d*numpoints ������ ���
% mulist : �� Ŭ������ ���� MUS�� ������ �ִ� ����Ʈ 
% sigmalist : �� Ŭ������ ���� SIGMAS�� ������ �ִ� ����Ʈ
% weightlist : �� Ŭ������ ���� WEIGHTS�� ������ �ִ� ����Ʈ 
% 
% ��� ���� :
% classes : �� ������ ���� �Ҵ�� Ŭ������ ������ �ִ� �� ���� 

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
