function [deltas] = outputDeltas(output,target)
  % deltas, output, target ��� ���� 
  sigmoidDeriv = output .* (ones(size(output)) - output);
  deltas = 2 * (target - output) .* sigmoidDeriv;