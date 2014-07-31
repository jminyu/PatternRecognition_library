% 실행 스크립트 파일 

clf  % 그림창을 지우고 
hold on  % 겹쳐 그리기 시작 
view(-37.5,30) % 뷰포인트 설정
plotPerceptronInput
xlabel('x1')
ylabel('x2')
zlabel('x3')
title('3-입력, 1-출력 퍼셉트론에 대한 결정 경계')
grid on
for patNum = 1:nPats,
  weights = trainPerceptron(patNum, weights,input,target,lRate);
end
plotDecisionSurf
weights
