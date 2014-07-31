% 학습 패턴 생성
digitPats;
nPats = size(patterns,2);
nTrainingPats = 20;
nTestPats = 20; % 나머지 20 개의 패턴은 테스트를 위해 저장
nInputs = size(patterns,1);
nHidden = 10;
nOutputs = 4;

% 바이어스 가중치를 포함하여, 작은 초기 가중치를 랜덤하게 설정
hiddenWeights = 0.5 * (rand(nHidden,nInputs+1) - ones(nHidden,nInputs+1) * .5);
outputWeights = 0.5 * (rand(nOutputs,nHidden+1) - ones(nOutputs,nHidden+1) * .5);

% 목표 패턴 설정(0: 1 0 0 0 , 1: 0 1 0 0, 2: 0 0 1 0, 3: 0 0 0 1)
input = patterns;
target = zeros(nOutputs,nPats);
class = 1;
for pat = 1:nPats,
  target(class,pat) = 1;
  class = class + 1;
  if class > nOutputs
    class = 1;
  end
end

eta = 0.1;  % 학습률 

NEpochs = 100; % 학습 epoch 수(모든 학습 데이터에 대하여 학습하는 수) = runbp가 호출되는 수
totalNEpochs = 0; % 지금까지의 학습 epoch 수. runbp가 호출될 때마다 NEpochs에 의하여 증가한다. 

% 학습 커브를 플롯
minEpochsPerErrorPlot = 200;
errorsPerEpoch = zeros(1,minEpochsPerErrorPlot);
TestErrorsPerEpoch = zeros(1,minEpochsPerErrorPlot);
epochs = [1:minEpochsPerErrorPlot];
