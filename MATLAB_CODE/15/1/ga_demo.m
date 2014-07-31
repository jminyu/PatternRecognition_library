% 유전자 알고리즘을 이용한 순회 판매원 문제(TSP)의 해결
% N: 도시의 수. 도시들은 1에서 N으로 라벨링. 
clear all
N=input('순회할 도시의 수: ');
%======================================================================
% N개의 도시에 대한 TSP 문제 생성 
pos=rand(N,2);  % 단위 정사각형내에 도시의 위치를 임의로 설정 
distance=dist(pos,pos); %도시간의 거리 행렬  
figure(1),clf
plot(pos(:,1),pos(:,2),'o') %도시 위치 표시
axis([0 1 0 1]), axis square, hold on
%그림상에 도시 번호 라벨링
for i=1:N
   text(pos(i,1)+.03,pos(i,2),int2str(i));
end
hold off
%========================================================================
% 유전자 탐색 
disp('********** 유전자 알고리즘*****************');
ngen=input('진화시킬 세대수: ');
ngpool=input('# 유전자 풀(gene pool)내의 개체(chromosoms)수: '); % 유전자 풀의 크기
gpool=zeros(ngpool,N); % 유전자 풀(gene pool)
% 유전자 풀 초기화 
for i=1:ngpool, 
   gpool(i,:)=[1 randomize([2:N]')'];
end
oldstep=0;
oldcostmin=99999;
costmin=N, tourmin=zeros(1,N); cost=zeros(1,ngpool); 
oldtourmin=gpool(2,:);
%========================================================================
for step=1:ngen, 
   % 1단계. 현재 개체의 적합도 평가, 순회 거리가 적합도가 되며 짧을수록 좋다.  
   for i=1:ngpool,
      cost(i)=sum(diag(distance(gpool(i,:)',rshift(gpool(i,:))')));
   end
   % 현재 최상의 패스를 기록 
   [costmin,idx]=min(cost);
   tourmin=gpool(idx,:);
   % 2단계. 교차(crossover)와 돌연변이(mutation) 연산 수행 
   [csort,ridx]=sort(cost); % 비용이 적은것에서 큰것으로 정렬한다. 
   
   for i=2:ngpool/2 
       sameidx=[gpool(2*i-1,:)==gpool(2*i,:)]; 
       diffidx=find(sameidx==0); 
       if length(diffidx)<=2 
           % 돌연변이생성
           gpool(2*i,:)=[1 randomize([2:N]')']; 
       else
           if i%3 == 0 % 부분교체교배
             [gpool(2*i-1,:),gpool(2*i,:)]=PMX(gpool(ridx(2*i-1),:),gpool(ridx(2*i),:));         
           end
           if i%3 == 1  % 순서교배
             [gpool(2*i-1,:),gpool(2*i,:)]=OX(gpool(ridx(2*i-1),:),gpool(ridx(2*i),:));
           end
           if i%3 == 2 % 주기교배
             [gpool(2*i-1,:),gpool(2*i,:)]=CX(gpool(ridx(2*i-1),:),gpool(ridx(2*i),:));
           end
       end 
   end 
   
   %pause;
   %최적순회 루트가 변하는 부분만 출력해주기 위한 처리 
   sameidx=[oldtourmin==tourmin]; % 같은 곳에는 #1로 마스크를 씌우고                            
   diffidx=find(sameidx==0); % 다른 인덱스를 찾아서 
   if length(diffidx) ~= 0 & costmin < oldcostmin     
       figure;
       plot(pos(:,1),pos(:,2),'o'),axis([0 1 0 1]), axis square, hold on 
       trip=pos(tourmin',:); trip=[trip; trip(1,:)]; 
       plot(trip(:,1),trip(:,2),'-');
       title(['세대:' num2str(step) ',  유전자 검색, 비용:' num2str(costmin)])
       hold off;
       drawnow
       disp(['세대' num2str(step) '::최적순회:'  num2str(tourmin)  '::비용:'  num2str(costmin) ]);
      oldcostmin = costmin;
      oldtourmin = tourmin;
      oldstep=step;
   end
end

disp(['비용 함수 평가 : ' int2str(ngen*2+ngpool) ' times!'])
disp(['최소 순회 거리 : ' num2str(oldcostmin)])
disp('최적 순회 : ') 
disp(num2str(oldtourmin))

figure
plot(pos(:,1),pos(:,2),'o'),axis([0 1 0 1]), axis square, hold on
trip=pos(oldtourmin',:); trip=[trip; trip(1,:)];
plot(trip(:,1),trip(:,2),'-')
title(['세대:' num2str(oldstep) ',  유전자 검색, 비용:' num2str(oldcostmin)])
hold off