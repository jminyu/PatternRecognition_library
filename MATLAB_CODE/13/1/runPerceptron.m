% ���� ��ũ��Ʈ ���� 

clf  % �׸�â�� ����� 
hold on  % ���� �׸��� ���� 
view(-37.5,30) % ������Ʈ ����
plotPerceptronInput
xlabel('x1')
ylabel('x2')
zlabel('x3')
title('3-�Է�, 1-��� �ۼ�Ʈ�п� ���� ���� ���')
grid on
for patNum = 1:nPats,
  weights = trainPerceptron(patNum, weights,input,target,lRate);
end
plotDecisionSurf
weights
