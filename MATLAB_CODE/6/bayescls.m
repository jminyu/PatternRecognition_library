function [y, dfce] = bayescls( X, model )
% BAYESCLS ����þ� �𵨿� ���� ���̽þ� �з���
% 
% ����:
%  �� �Լ��� ����þ� �𵨿� ���� �Է� ���� X�� ���� ����Ȯ���� ����ϰ� 
%  �Է� ���͵��� ���� Ȯ������ ���� ū Ŭ������ �з� �Ǿ�����. 
%  
% �Է�:
%  X [dim x num_data] �з��ϰ����ϴ� �Է� ���� 
%
%  model.Mu [dim x num_classes] ����þ� ���� ��� ����.
%  model.C [dim x dim x num_classes] ����þ� ���� ���л� ���.
%  model.P [1 x num_classes] ���� Ȯ����.
%
% ���:
%  y [1 x num_data] �� 
%  dfce [num_classes x num_data] Ȯ���� P(x|y)*P(y), 
%   ���⼭,  x�� �з��� �����̰� y�� Ŭ���� �ĺ����̴�. 
%

[dim,num_data]=size(X);
num_classes = size(model.Mu,2);

dfce=zeros(num_classes,num_data);

for i=1:num_classes,
  nconst = 1/((2*pi)^(dim/2) * sqrt(det(model.C(:,:,i))));
    
  dfce(i,:) = ...
     model.P(i)*nconst*exp(-0.5*mahalan(X,model.Mu(:,i),model.C(:,:,i)));
end

[tmp,y] = max(dfce);

return;


