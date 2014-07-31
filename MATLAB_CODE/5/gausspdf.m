function [z] = gausspdf(x,mu,sigma);

% GAUSSPDF ����þ� Ȯ�� �е� �Լ��� ���ϱ� 
%
%    GAUSSPDF(X,MU,SIGMA)�� ��� MUdhk ���л� SIGMA�� ���� 
%    ����þ� ���μ����� ���� ������ X Ȥ�� �������� �쵵�� �����Ѵ�. 
%    MU�� 1*D ����(���⼭ D�� ���μ����� ����)
%    SIGMA�� D*D ���
%    X�� N*D ��ķ� �� ���� �ϳ��� D-���� ������ ���� �ȴ�.  
%
%    See also MEAN, COV, GLOGLIKE

[N,D] = size(x);
if (min(N,D) == 1), x=x(:)'; end;

invSig = inv(sigma);
mu = mu(:)';

x = x-repmat(mu,N,1);

z = sum( ((x*invSig).*x), 2 );

z = exp(-0.5*z) / sqrt((2*pi)^D * det(sigma));
