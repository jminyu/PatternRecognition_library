%%% 퍼셉트론  학습 파일
function [newWts] = trainPerceptron(patNum,wts,pats,targ,lrate)
nOutputs = size(targ,1);
for i = 1:nOutputs,
   inputVector = pats(:,patNum);
   targetOutput = targ(i,patNum);
   totalInput = dot(wts(i,:),inputVector);
   if (totalInput > 0) 
     activation = 1;
   else activation = -1;
   end	
   if (activation > targetOutput)
     %% unit is on but should be off 
     wts(i,:) = wts(i,:) - lrate * inputVector';
   elseif (activation < targetOutput)
     %% unit is off but should be on
     wts(i,:) = wts(i,:) + lrate * inputVector';
   end
end 
newWts = wts;
