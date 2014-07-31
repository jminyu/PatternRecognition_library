function [x,esq,j] = kmeans(d,k,x0)
%KMEANS K-means 알고리즘을 이용한 벡터 양자화 [X,ESQ,J]=(D,K,X0)%입력 인자:
% D 데이터 벡터(one per row)
% K 중심 갯수
% X0 초기 중심값(옵션)
%
%출력 인자:
% X 출력 열 벡터(K 개의 열)
% ESQ 평균 자승 오차(mean square error)
% J 각 데이터 벡터가 어느 중심에 속하는가의 색인 
%
%   VOICEBOX 공개소스 수정
%   VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
[n,p] = size(d);
if nargin<3
   x = d(ceil(rand(1,k)*n),:);
else
   x=x0;
end
y = x+1;
iter = 0;
while any(x(:) ~= y(:))
   iter = iter + 1;
   z = disteusq(d,x,'x');
   [m,j] = min(z,[],2);
   y = x;
   for i=1:k
      s = j==i;
      if any(s)
         x(i,:) = mean(d(s,:),1);
      else
         q=find(m~=0);
         if isempty(q) break; end
         r=q(ceil(rand*length(q)));
         x(i,:) = d(r,:);
         m(r)=0;
         y=x+1;
      end
   end
end
esq=mean(m,1);