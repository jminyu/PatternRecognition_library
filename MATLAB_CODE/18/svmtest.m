clear all;    % 메모리로 부터 모든 변수 제거 
close all
% 데이터 읽어오기 
nsample = 100;
%fid = fopen('noise.txt', 'r');  % 파일 열기(선형 분리 불가능한 데이터) 
fid = fopen('clean.txt', 'r');  % 파일 열기(선형 분리 가능한 데이터)
[Dataset, count] = fscanf(fid, '%f %f', [2, nsample]);% read in examples (x,y) as a 2 * nsample matrix
fclose(fid);           % 파일 닫기 
Dataset = Dataset';    % 전치
X = Dataset(:,1);      % 1차원 X값 설정  
Y = Dataset(:,2);      % Y값 설정 

sample_plus=X(find(Y>0));
sample_minus=X(find(Y<0));

figure

plot(sample_plus,0,'ro');
hold on
plot(sample_minus,0,'b+');
hold off

% 시험할 trade-off 가중치(weights) C 설정

C = [0.01, 0.1, 1, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, inf];

Margin = [];    % 마진; 널(NULL)로 초기화 
nSV = [];      % 서포트 벡터의 수;
nMis = [];      % 오분류 데어터 수;
Err = [];       % 학습 오차;

for n = 1 : max(size(C)),
    % Hessian 행렬 구축; Hessian 행렬은 Q 행렬이라고도 하고 Kernel 행렬이라고도 한다. 
    H = zeros(nsample, nsample); % H 초기화; H를 nsample * nsample 영행렬로 설정
    for i = 1 : nsample,
        for j = 1 : nsample,
            H(i,j) = X(i)*X(j)*Y(i)*Y(j);  % 중요
        end
    end
    
    H = H+1e-10*eye(size(H));  % H를 안정하게 하기 위한 트릭으로 주대각성분에 1e-10을 더한다. 

    F = -ones(nsample,1);     % F' * Alpha는 목적함수에서 sigma_i(Alpha_i)와 관련됨

    % 항등 제약식(equality constraints) 설정
    A = Y';  % sigma_i(Alpha_i * Y_i) = 0
    b = 0;

    % alpha에 대한 상한 하한 설정: LB <= Alpha <= UB
    LB = zeros(nsample,1);     % UB와 LB는 nsample * 1 행렬임에 주의 
    UB = C(n)*ones(nsample,1); % 

    % alpha의 시작점 
    Alpha0 = zeros(nsample, 1);

    % QP(quadratic programming)로 alpha 최적화 
    Alpha = quadprog(H, F, [], [], A, b, LB, UB, Alpha0);
    % Alpha = qp(H, F, A, b, LB, UB, Alpha0, 1);

    % 서포트 벡터를 구하는 허용오차; 허용오차보다 작은 알파값은 무시.  
    tol = 0.0001;

    % 가중치(weight) 계산
    w = 0;
    for i = 1 : nsample,
        w = w + Alpha(i) * Y(i) * X(i);
    end

    % 바이어스 계산 
    bias = 0;
    b1 = 0;
    b2 = 0;
    for i = 1 : nsample,
	if (Alpha(i) > tol & Alpha(i) < C(n) - tol),
	    b1 = b1 + X(i) * w - Y(i);
            b2 = b2 - 1;
        end
    end
   
    if b2 ~= 0,
        bias = b1 / b2;
    else    % unlikely
        b1 = 0;        
        for i = 1 : nsample,
            if Alpha(i) < tol,
	        b1 = b1 + X(i) * w - Y(i);
                b2 = b2 - 1;
            end
        end
        
	if b2 ~= 0,
	    bias = b1 / b2;
        else    % even unlikelier
	    b1 = 0;
            for i = 1 : nsample,
	        b1 = b1 + X(i) * w - Y(i);
                b2 = b2 - 1;
            end
	    if b2 ~= 0,
	        bias = b1 / b2;
            end
        end
    end

    % margin = 2 / ||w||
    Margin = [Margin, 2 / abs(w)]; % A = [A, v] 연산은 A행렬에 v를 추가 

    % 서포트 벡터의 개수 
    nSV = [nSV, size(find(Alpha > tol), 1)];

    % 오분류와 학습 오차의 수를 계산
    m = 0;
    e = 0;
    for i = 1 : nsample,
	predict = w * X(i) + bias;    % Y = w * X + b
        if predict >= 0 & Y(i) < 0,
            m = m + 1;
        end
        if predict < 0 & Y(i) >= 0,
            m = m + 1;
        end        
        if Alpha(i) > tol,    % 서포트 벡터만을 고려 
	    e = e + 1 - predict * Y(i);
        end  
    end
    nMis = [nMis, m];
    Err = [Err, e];
end

% trade-off 가중치(weights) C에 에 따른 마진, 학습에러, 오분류 데이터 수, 서포트 벡터의 수 그리기

Z = zeros(size(C));
for i = 1 : size(C, 2)
     Z(i) = i;
end

figure
%plot(Z, Margin);
stem(Z, Margin);
title('마진');
xlabel('C(i)');

figure
%plot(Z, Err);
stem(Z, Err);
title('학습 에러');
xlabel('C(i)');

figure
%plot(Z, nMis);
stem(Z, nMis);
title('오분류 데이터 수');
xlabel('C(i)');

figure
%plot(Z, nSV);
stem(Z, nSV);
title('Support Vector 수');
xlabel('C(i)');
