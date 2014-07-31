% 퍼셉트론 초기화 

nPats = 30;
mid = nPats/2; % 패턴의 절반은 목표 패턴이 1이되고 나머지는 -1이 된다. 
inputDim = 3; % 입력 뉴런 수 
outputDim = 1; % 출력 뉴런 수 
lRate = 0.1;  % 학습률 

% 연결 가중치는 랜덤하게 만든다. 
% 각 행은 출력 유닛에 대한 연결 가중 벡터이다. 
% 각 행의 나머지 성분은 바이어스 연결 가중치이다. 
weights = rand(outputDim,inputDim+1);
% 입력 패턴 행렬 설정 :
% 각 열은 가우시안 랜덤 변수로 생성시킨 학습 패턴이다. 
% 처음 절반은 평균값이 작게 나머지는 평균값이 큰값으로 
% 마지막 행은 모두 1로 한다. 이는 바이어스 연결에 해당하며 상수이다. (bias weight = - threshold)
mean1 = 0.25; % 패턴 절반 = 작은 평균값 
mean2 = 0.75; % 패턴의 나머지 절반  = 큰 평균값 
var = 0.1;  % 가우시안 패턴 분포의 분산값
input = zeros(inputDim+1,nPats);
input(1:inputDim,1:mid) = randn(inputDim,mid)*var+mean1*ones(inputDim,mid);
input(1:inputDim,mid+1:nPats) = randn(inputDim,mid)*var+mean2*ones(inputDim,mid);
input(inputDim+1,:) = ones(1,nPats);

% 목표 출력 행렬 설정 :
% 이는 각 학습 패턴에 대하여 출력 유닛의 각각의 목표값에 대한 바른 상태를 결정한다. 
% 처음 절반의 학습 패턴에 대하여는 원하는 출력이 모두 1에 되도록 하고 나머지는 모두 -1이 되도록 한다.
target = ones(outputDim,nPats);
target(1:outputDim,mid+1:nPats) = -1*target(1:outputDim,mid+1:nPats);
