function [y, dfce] = bayescls( X, model )
% BAYESCLS 가우시안 모델에 대한 베이시안 분류기
% 
% 설명:
%  이 함수는 가우시안 모델에 따라 입력 벡터 X에 대한 사후확률을 계산하고 
%  입력 벡터들은 사후 확률값이 가장 큰 클래스로 분류 되어진다. 
%  
% 입력:
%  X [dim x num_data] 분류하고저하는 입력 벡터 
%
%  model.Mu [dim x num_classes] 가우시안 모델의 평균 벡터.
%  model.C [dim x dim x num_classes] 가우시안 모델의 공분산 행렬.
%  model.P [1 x num_classes] 사전 확률값.
%
% 출력:
%  y [1 x num_data] 라벨 
%  dfce [num_classes x num_data] 확률값 P(x|y)*P(y), 
%   여기서,  x는 분류된 벡터이고 y는 클래스 식별자이다. 
%

[dim,num_data]=size(X);
num_classes = size(model.Mu,2);

dfce=zeros(num_classes,num_data);

for i=1:num_classes,
  nconst = 1/((2*pi)^(dim/2) * sqrt(det(model.C(:,:,i))));
    
  dfce(i,:) = ...
     model.P(i)*nconst*exp(-0.5*mahalan(X,model.Mu(:,i),model.C(:,:,i)));
end

[tmp,y] = max(dfce);

return;


