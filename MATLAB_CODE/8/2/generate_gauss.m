% X = generate_gauss(muvec,covmat,numpoints);
%
% numpoints ���� ��ŭ�� Ư¡ ���� ������ ������ ����. 
% ������ �����ʹ� ������ ����þ� ������ ������. 
%
% �Է� ����:
% muvec: d-������ ��� ����
% covmat: d*d ���л� ���
%
% ��� ����:
% X�� ���� d������ Ư¡������ ������ ����̴�. 

function X = generate_gauss(muvec,covmat,numpoints);

d = length(muvec);
if (size(covmat) == [d,d]) == 0
   error('Incompatible dimensions!');
end

X = inv(whiten(covmat)') * randn(d,numpoints) + muvec'*ones(1,numpoints);
