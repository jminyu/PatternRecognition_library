function [x,esq,j] = kmeanlbg(d,k)
%KMEANLBG Linde-Buzo-Gray �˰����� �̿��� ���� ����ȭ [X,ESQ,J]=(D,K)
%�Է� ����:
% D ������ ����(one per row)
% K �߽� ����
%
%��� ����:
% X ��� �� ����(K ���� ��)
% ESQ ��� �ڽ� ����(mean square error)
% J �� ������ ���Ͱ� ��� �߽ɿ� ���ϴ°��� ���� 
%
%
%  Implements LBG K-means algorithm:
%  Linde, Y., A. Buzo, and R. M. Gray,
%  "An Algorithm for vector quantiser design,"
%  IEEE Trans Communications, vol. 28, pp.84-95, Jan 1980.
%  VOICEBOX ���� �ҽ� ����
%  VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
nc=size(d,2);
[x,esq,j]=kmeans(d,1);
m=1;
iter = 0;
while m<k
   iter = iter + 1;
   n=min(m,k-m);
   m=m+n;
   e=1e-4*sqrt(esq)*rand(1,nc);
   [x,esq,j]=kmeans(d,m,[x(1:n,:)+e(ones(n,1),:); x(1:n,:)-e(ones(n,1),:); x(n+1:m-n,:)]);

   % ���� ������ �����ֱ�
   color = 'rgbkcmy';
   for i = 1:m
      r = (j == i);
      z = d(r,:);
      scatter(z(:,1),z(:,2),10,color(i));
   end
   scatter(x(:,1),x(:,2),'b','filled'); % ���ŵ� Ŭ������ �߽�
   title([' LBG : �ݺ���:',num2str(iter)]);
   pause
   drawnow;
end
