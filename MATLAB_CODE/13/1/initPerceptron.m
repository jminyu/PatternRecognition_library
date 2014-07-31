% �ۼ�Ʈ�� �ʱ�ȭ 

nPats = 30;
mid = nPats/2; % ������ ������ ��ǥ ������ 1�̵ǰ� �������� -1�� �ȴ�. 
inputDim = 3; % �Է� ���� �� 
outputDim = 1; % ��� ���� �� 
lRate = 0.1;  % �н��� 

% ���� ����ġ�� �����ϰ� �����. 
% �� ���� ��� ���ֿ� ���� ���� ���� �����̴�. 
% �� ���� ������ ������ ���̾ ���� ����ġ�̴�. 
weights = rand(outputDim,inputDim+1);
% �Է� ���� ��� ���� :
% �� ���� ����þ� ���� ������ ������Ų �н� �����̴�. 
% ó�� ������ ��հ��� �۰� �������� ��հ��� ū������ 
% ������ ���� ��� 1�� �Ѵ�. �̴� ���̾ ���ῡ �ش��ϸ� ����̴�. (bias weight = - threshold)
mean1 = 0.25; % ���� ���� = ���� ��հ� 
mean2 = 0.75; % ������ ������ ����  = ū ��հ� 
var = 0.1;  % ����þ� ���� ������ �л갪
input = zeros(inputDim+1,nPats);
input(1:inputDim,1:mid) = randn(inputDim,mid)*var+mean1*ones(inputDim,mid);
input(1:inputDim,mid+1:nPats) = randn(inputDim,mid)*var+mean2*ones(inputDim,mid);
input(inputDim+1,:) = ones(1,nPats);

% ��ǥ ��� ��� ���� :
% �̴� �� �н� ���Ͽ� ���Ͽ� ��� ������ ������ ��ǥ���� ���� �ٸ� ���¸� �����Ѵ�. 
% ó�� ������ �н� ���Ͽ� ���Ͽ��� ���ϴ� ����� ��� 1�� �ǵ��� �ϰ� �������� ��� -1�� �ǵ��� �Ѵ�.
target = ones(outputDim,nPats);
target(1:outputDim,mid+1:nPats) = -1*target(1:outputDim,mid+1:nPats);
