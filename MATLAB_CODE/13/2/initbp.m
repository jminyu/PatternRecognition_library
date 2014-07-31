% �н� ���� ����
digitPats;
nPats = size(patterns,2);
nTrainingPats = 20;
nTestPats = 20; % ������ 20 ���� ������ �׽�Ʈ�� ���� ����
nInputs = size(patterns,1);
nHidden = 10;
nOutputs = 4;

% ���̾ ����ġ�� �����Ͽ�, ���� �ʱ� ����ġ�� �����ϰ� ����
hiddenWeights = 0.5 * (rand(nHidden,nInputs+1) - ones(nHidden,nInputs+1) * .5);
outputWeights = 0.5 * (rand(nOutputs,nHidden+1) - ones(nOutputs,nHidden+1) * .5);

% ��ǥ ���� ����(0: 1 0 0 0 , 1: 0 1 0 0, 2: 0 0 1 0, 3: 0 0 0 1)
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

eta = 0.1;  % �н��� 

NEpochs = 100; % �н� epoch ��(��� �н� �����Ϳ� ���Ͽ� �н��ϴ� ��) = runbp�� ȣ��Ǵ� ��
totalNEpochs = 0; % ���ݱ����� �н� epoch ��. runbp�� ȣ��� ������ NEpochs�� ���Ͽ� �����Ѵ�. 

% �н� Ŀ�긦 �÷�
minEpochsPerErrorPlot = 200;
errorsPerEpoch = zeros(1,minEpochsPerErrorPlot);
TestErrorsPerEpoch = zeros(1,minEpochsPerErrorPlot);
epochs = [1:minEpochsPerErrorPlot];
