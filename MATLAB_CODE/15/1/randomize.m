function B=randomize(A,rowcol)
% ��� A�� �� Ȥ�� ���� �����ϰ� ����
% rowcol: 0 Ȥ�� ������ ���� �����ϰ� ���� (default)
%         1 �̸�, ���� �����ϰ� ����

rand('state',sum(100*clock))
if nargin == 1,
   rowcol=0;
end
if rowcol==0, 
   [m,n]=size(A);
   p=rand(m,1);
   [p1,I]=sort(p);
   B=A(I,:);
elseif rowcol==1,
   Ap=A';
   [m,n]=size(Ap);
   p=rand(m,1);
   [p1,I]=sort(p);
   B=Ap(I,:)';
end
