function B=randomize(A,rowcol)
% 행렬 A를 행 혹은 열을 랜덤하게 섞기
% rowcol: 0 혹은 없으면 행을 랜덤하게 섞기 (default)
%         1 이면, 열을 랜덤하게 섞기

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
