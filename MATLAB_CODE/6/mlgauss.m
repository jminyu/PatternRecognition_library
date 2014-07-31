function model=mlgauss(data,cov_type)
% MLGAUSS는 최우추정으로 주어진 데이터에 대한 가우시안 분포를 계산한다. 
% 
% 사용법:
%  model=mlgauss(data)
%  model=mlgauss(data,cov_type)
% 
% 설명:
%  주어진 데이터에 대한 가우시안 분포의 최우추정을 계산한다. 
%  ML 추정은 다음 수식을 푸는 것과 같다:
%    (mu^*,C^*)=arg max sum Alpha(x)*log( N(x,mu,C) )
%                        mu,C   x
%  
%  여기서 표본 X는 i.i.d. 라고 가정한다. 
%
%  Alpha(x)는 표본에서 표본 x의 발생을 결정한다. (사전 확률)  
%  디폴트는 모든 데이터에 대하여 1이다. 이러한 데이터 가중은 예를 들어
%  알고리즘에서 완전한 우도 함수를 추정하여 계산할 때 유용한다. 
%
%  입력 인수 데이터는 다음중 하나가 될 수 있다.  
%   1) 표본 X를 포함하는 행렬 [dim x num_data] 
%   2) 샘플 X [dim x num_data],라벨 y [1 x num_data] 
%           그리고 가중값 Alpha [1 x num_data]를 포함하는 구조체 
%      만약, 라벨이 주어진다면 ML 추정은 특별히 각 클래스에 대하여 수행된다.   
%
%  추정되는 공분산 행렬의 형태는 다음과 같은 것이 될 수 있다:
%     1 ... 완전 공분산 행렬(Full covariance matrix)
%     2 ... 대각 공분산 행렬(Diagonal covariance matrix)
%     3 ... Cov. matrix c*eye(dim,dim). eye(dim,dim): 항등행렬
%
% 입력 :
%  data [dim x num_data] Data sample.
%  혹은 
%  data.X [dim x num_data] 데이터 샘플.
%  data.y [1 x num_data] 라벨 (default ones(1,num_data)).
%  data.Alpha [1 x num_data] 데이터의 가중값 (default ones(1,num_data)).
%
%  cov_type [int] 공분산 행렬의 형태 (defualt 1).
%
% 출력 :
%  model.Mu [dim x num_classes] 추정된 평균 벡터.
%  model.C [dim x dim x num_classes] 추정된 공분산 행렬.
%
% Example:
%  help mmgauss;
%
% See also MMGAUSS.
%
% -- Processing of input arguments -----------------------------------

data=c2s(data);

if ~isstruct(data),
   data.X = data;
end

[dim, num_data] = size( data.X );

if ~isfield(data,'y'), data.y = ones(1,num_data); end
if ~isfield(data,'Alpha'), data.Alpha = ones(1,num_data); end

if nargin < 2, cov_type=1; end
  
% -- compute ML estimated for all classes ------
num_classes=max(data.y);

model.Mu = zeros(dim,num_classes);
model.C = zeros(dim,dim,num_classes);

for i=1:num_classes,
   
   inx = find(data.y==i);
   
   Alpha=data.Alpha(inx); Alpha=Alpha(:);
   sum_Alpha = sum(Alpha);
   X = data.X(:,inx);
   num_data = size(X,2);
   
   %------------------------------   
   model.Mu(:,i) = X*Alpha/sum_Alpha;
   
   XC=X-repmat( model.Mu(:,i),1,num_data);

  if cov_type==1,
    % asssumes correlated features
    model.C(:,:,i) = (XC.*(repmat(Alpha',dim,1)))*XC'/(sum_Alpha);
  elseif cov_type==2,
    % asssumes uncorrelated features -> diagonal cov. matrix
    model.C(:,:,i) = diag(sum((XC.*repmat(Alpha',dim,1).*XC)')/(sum_Alpha));
  else
    % asssumes isotropic cov. -> diagonal cov. = c*eye()
    model.C(:,:,i) = eye(dim,dim)*...
      sum(sum((XC.*repmat(Alpha',dim,1).*XC)'))/((sum_Alpha)*dim);
  end
end

model.cov_type = cov_type;
model.y = [1:num_classes];

return; 
