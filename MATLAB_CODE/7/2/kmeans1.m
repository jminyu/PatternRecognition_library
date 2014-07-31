function   CBout = kmeans1(CBin, X, delta) 
% 입력 인자: 
% CBin: 초기 코드북, N X K 행렬, 각 열은 K 차원의 코드 벡터 
% X: 학습 벡터 열, M X K 행렬, 각 열은 K 차원의 학습 벡터 
% delta: 알고리즘을 중지하기 위한 이전과 현재의 상대적인 왜곡의 임계값
%
% 출력 인자:  
% CBout: LBG 알고리즘으로 생성되는 최종적인 코드북
% 내부인자:
%  C   : 내부적인 조작을 위한 코드북
%  Q   : M X 1 벡터, 각 성분은 입력 벡터가 어느 클러스터에 속하는가를 가르킨다. 
%
% 초기화 
[M,K] = size(X);
[N,K] = size(CBin);
C = zeros(size(CBin));
C = CBin;
Q = zeros(M,1);
n = 1;
AvgDist = [];
CBout = zeros(size(CBin));

% 
% N 개의 클러스터로 학습열을 나눈다.
for i =1:M
    min = inf;
    for j = 1:N
        if dist(X(i,:),C(j,:)) <= min
            min = dist(X(i,:),C(j,:));
            Q(i) = j;
        end
    end
end

% 나눈 데이터 보여주기
color = 'rgbkcmy';

for i = 1:N
   r = (Q == i);
   z = X(r,:);
   scatter(z(:,1),z(:,2),10,color(i));
end

% 평균 왜곡과 이전과 현재의 상대적인 왜곡 계산  
AvgDist =[AvgDist, AverageDistortion(X,C)];
RelaDist = 1;
 
while RelaDist > delta
    % 새로운 코드북을 만든다. 
    for i = 1:N
        Index = (Q == i);
        C(i,:) = Index'* X / sum(Index);
    end
    n = n+1;
    
    % N 개의 클러스터로 학습열을 나눈다. 
    for i =1:M
     min = inf;
       for j = 1:N
          if dist(X(i,:),C(j,:)) <= min
            min = dist(X(i,:),C(j,:));
            Q(i) = j;
          end
       end
   end
   % 평균 왜곡과 이전과 현재의 상대적인 왜곡을 구한다.  
   temp = AverageDistortion(X,C);
   AvgDist = [AvgDist, temp];
   RelaDist = abs((AvgDist(n-1)-AvgDist(n))/AvgDist(n));
   CBout = C;
   % 군집화 진행중의 분할 갱신 데이터 보여주기
   for i = 1:N
      r = (Q == i);
      z = X(r,:);
      scatter(z(:,1),z(:,2),10,color(i));
   end
   scatter(CBout(:,1),CBout(:,2),'b','filled'); % 갱신된 클러스터 중심
   title([' 반복수:',num2str(n)]);
   drawnow;
end
% 최종 클러스터 중심 리턴 
CBout = C