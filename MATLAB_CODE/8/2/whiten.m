% Aw = whiten(covmat);
%
% 공분산 행렬 covmat인 데이터 집합에 대한 whitening 변환인  
% 행렬 Aw를 리턴한다
% whitening 변환
% V=D^(-1/2)*R^T
% D: 대각 성분의 고유값 
% R: 공분산 행렬의 직교 고유벡터 

function Aw = whiten(covmat);

[phi, lambda] = eig(covmat);
Aw = phi/sqrt(lambda);
