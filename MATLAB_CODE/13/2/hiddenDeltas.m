function [deltas] = hiddenDeltas(outputDeltas,hiddenOutputs,outputWeights)
  % deltas, outputs�� ������. 
  % outputWeights�� hidden->output ����ġ ��� (�� ���� ��� ������ ����ġ ����)
  sigmoidDeriv = hiddenOutputs .* (ones(size(hiddenOutputs)) - hiddenOutputs);
  deltas = (outputWeights' * outputDeltas) .* sigmoidDeriv;