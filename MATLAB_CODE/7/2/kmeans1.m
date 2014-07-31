function   CBout = kmeans1(CBin, X, delta) 
% �Է� ����: 
% CBin: �ʱ� �ڵ��, N X K ���, �� ���� K ������ �ڵ� ���� 
% X: �н� ���� ��, M X K ���, �� ���� K ������ �н� ���� 
% delta: �˰����� �����ϱ� ���� ������ ������ ������� �ְ��� �Ӱ谪
%
% ��� ����:  
% CBout: LBG �˰������� �����Ǵ� �������� �ڵ��
% ��������:
%  C   : �������� ������ ���� �ڵ��
%  Q   : M X 1 ����, �� ������ �Է� ���Ͱ� ��� Ŭ�����Ϳ� ���ϴ°��� ����Ų��. 
%
% �ʱ�ȭ 
[M,K] = size(X);
[N,K] = size(CBin);
C = zeros(size(CBin));
C = CBin;
Q = zeros(M,1);
n = 1;
AvgDist = [];
CBout = zeros(size(CBin));

% 
% N ���� Ŭ�����ͷ� �н����� ������.
for i =1:M
    min = inf;
    for j = 1:N
        if dist(X(i,:),C(j,:)) <= min
            min = dist(X(i,:),C(j,:));
            Q(i) = j;
        end
    end
end

% ���� ������ �����ֱ�
color = 'rgbkcmy';

for i = 1:N
   r = (Q == i);
   z = X(r,:);
   scatter(z(:,1),z(:,2),10,color(i));
end

% ��� �ְ�� ������ ������ ������� �ְ� ���  
AvgDist =[AvgDist, AverageDistortion(X,C)];
RelaDist = 1;
 
while RelaDist > delta
    % ���ο� �ڵ���� �����. 
    for i = 1:N
        Index = (Q == i);
        C(i,:) = Index'* X / sum(Index);
    end
    n = n+1;
    
    % N ���� Ŭ�����ͷ� �н����� ������. 
    for i =1:M
     min = inf;
       for j = 1:N
          if dist(X(i,:),C(j,:)) <= min
            min = dist(X(i,:),C(j,:));
            Q(i) = j;
          end
       end
   end
   % ��� �ְ�� ������ ������ ������� �ְ��� ���Ѵ�.  
   temp = AverageDistortion(X,C);
   AvgDist = [AvgDist, temp];
   RelaDist = abs((AvgDist(n-1)-AvgDist(n))/AvgDist(n));
   CBout = C;
   % ����ȭ �������� ���� ���� ������ �����ֱ�
   for i = 1:N
      r = (Q == i);
      z = X(r,:);
      scatter(z(:,1),z(:,2),10,color(i));
   end
   scatter(CBout(:,1),CBout(:,2),'b','filled'); % ���ŵ� Ŭ������ �߽�
   title([' �ݺ���:',num2str(n)]);
   drawnow;
end
% ���� Ŭ������ �߽� ���� 
CBout = C