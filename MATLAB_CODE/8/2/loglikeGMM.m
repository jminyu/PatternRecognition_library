function [loglike, pmat] = loglikeGMM(X, mus, sigmas, weights);

% �밢 ����þ��� �ͽ��Ŀ� ���� X�� �� ������ ������ �α� �쵵�� �����Ѵ�. 
% ���� �� �ͽ��� ���а� ������ ���� ���� ���� ���ھ��� ( p(x_n|m)c_m )��
% �����ϰ� �ִ� M*numpoints ����� �����Ѵ�.
%
% �Է� ���� :
% X : ���� d-������ Ư¡ ���͵��� ������ ����̴�.
% mus : d*M ��ķ� �� ���� �ͽ��� ���п� ���� ��� ����.
% sigmas : d*M ��ķ� �� ���� �ͽ��� ȥ�� ���п� ���� �л� ����.
% weights : M-���� ���ͷ� �ͽ��� ����ġ.
%
% ��� ���� :
% loglike : �α�-�쵵���� �� ����.
% pmat : ������ �����ѰͰ� ���� ���ھ�� �ͽ��� ������ ���.

  
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
