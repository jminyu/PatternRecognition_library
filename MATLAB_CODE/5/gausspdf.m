function [z] = gausspdf(x,mu,sigma);

% GAUSSPDF 가우시안 확률 밀도 함수값 구하기 
%
%    GAUSSPDF(X,MU,SIGMA)는 평균 MUdhk 공분산 SIGMA에 따른 
%    가우시안 프로세스에 따른 데이터 X 혹은 데이터의 우도를 리턴한다. 
%    MU는 1*D 벡터(여기서 D는 프로세스의 차원)
%    SIGMA는 D*D 행렬
%    X는 N*D 행렬로 각 행이 하나의 D-차원 데이터 점이 된다.  
%
%    See also MEAN, COV, GLOGLIKE

[N,D] = size(x);
if (min(N,D) == 1), x=x(:)'; end;

invSig = inv(sigma);
mu = mu(:)';

x = x-repmat(mu,N,1);

z = sum( ((x*invSig).*x), 2 );

z = exp(-0.5*z) / sqrt((2*pi)^D * det(sigma));
