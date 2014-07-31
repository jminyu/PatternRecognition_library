function y = AverageDistortion (X,C)
% 평균왜곡 계산 
% 입력 인자 :
%  X:  학습 벡터 열, M x K 행렬, 각 행은 K차원의 학습벡터이다
% C:  코드북, N x K 행렬, 각 행은 K차원의 코드워드이다. 
% 출력 인자 :
%  y:  학습열의 평균 왜곡과 코드북
[M,K] = size(X);
[N,K] = size(C);
D = 0;
 
for i = 1:M
    min = inf;
    for j = 1:N
        if dist(X(i,:),C(j,:)) < min
            min = dist(X(i,:),C(j,:));
        end
    end
    D = D + min;
end
y = D/M;