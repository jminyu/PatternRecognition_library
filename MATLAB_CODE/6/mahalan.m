function dist=mahalan(X,mu,C)
% MAHALAN 마하라노비스 거리를 계산한다. 
%
% 용법:
%  dist=mahalan(X,mu,C)
%
% 설명:
%  행렬 X와 벡터 mu 그리고 행렬 C인 점들 간의 마하라노비스 거리를 계산한다. 
%    dist = (x-mu)'*inv(C)*(x-mu),
%  여기서 x는 X의 열벡터이다. 
%
% 입력:
%  X [dim x num_data] 입력 데이터.
%  mu [dim x 1] 벡터 mu.
%  C [dim x dim] 행렬 C.
%
% 출력:
%  dist [1 x num_data] 마하라노비스 거리.
%


[dim, num_data] = size( X );

XC = X - repmat(mu,1,num_data);
dist= sum((XC'*inv( C ).*XC')',1);

return;
