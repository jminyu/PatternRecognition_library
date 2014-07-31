function dist=mahalan(X,mu,C)
% MAHALAN ���϶��� �Ÿ��� ����Ѵ�. 
%
% ���:
%  dist=mahalan(X,mu,C)
%
% ����:
%  ��� X�� ���� mu �׸��� ��� C�� ���� ���� ���϶��� �Ÿ��� ����Ѵ�. 
%    dist = (x-mu)'*inv(C)*(x-mu),
%  ���⼭ x�� X�� �������̴�. 
%
% �Է�:
%  X [dim x num_data] �Է� ������.
%  mu [dim x 1] ���� mu.
%  C [dim x dim] ��� C.
%
% ���:
%  dist [1 x num_data] ���϶��� �Ÿ�.
%


[dim, num_data] = size( X );

XC = X - repmat(mu,1,num_data);
dist= sum((XC'*inv( C ).*XC')',1);

return;
