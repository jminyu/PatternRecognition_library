% Aw = whiten(covmat);
%
% ���л� ��� covmat�� ������ ���տ� ���� whitening ��ȯ��  
% ��� Aw�� �����Ѵ�
% whitening ��ȯ
% V=D^(-1/2)*R^T
% D: �밢 ������ ������ 
% R: ���л� ����� ���� �������� 

function Aw = whiten(covmat);

[phi, lambda] = eig(covmat);
Aw = phi/sqrt(lambda);
