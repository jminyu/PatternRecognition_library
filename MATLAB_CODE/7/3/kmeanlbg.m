function [x,esq,j] = kmeanlbg(d,k)
%KMEANLBG Linde-Buzo-Gray 알고리즘을 이용한 벡터 양자화 [X,ESQ,J]=(D,K)
%입력 인자:
% D 데이터 벡터(one per row)
% K 중심 갯수
%
%출력 인자:
% X 출력 열 벡터(K 개의 열)
% ESQ 평균 자승 오차(mean square error)
% J 각 데이터 벡터가 어느 중심에 속하는가의 색인 
%
%
%  Implements LBG K-means algorithm:
%  Linde, Y., A. Buzo, and R. M. Gray,
%  "An Algorithm for vector quantiser design,"
%  IEEE Trans Communications, vol. 28, pp.84-95, Jan 1980.
%  VOICEBOX 공개 소스 수정
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

   % 나눈 데이터 보여주기
   color = 'rgbkcmy';
   for i = 1:m
      r = (j == i);
      z = d(r,:);
      scatter(z(:,1),z(:,2),10,color(i));
   end
   scatter(x(:,1),x(:,2),'b','filled'); % 갱신된 클러스터 중심
   title([' LBG : 반복수:',num2str(iter)]);
   pause
   drawnow;
end
