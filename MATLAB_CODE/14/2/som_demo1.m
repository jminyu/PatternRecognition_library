clear
clf,figure(1)
N=100; % 각 클러스터의 표본의 갯수
N2=N+N; B1=ceil(N/2); B2=N+B1;
eta=0.2;
means=[0.7  -0.8      
       0.7  -0.8];
var= [0.2  0.2];

x=datagen([N N],[means;var]); % x : 2N by 2
x=randomize(x);% 행의 값을 랜덤하게 섞기
disp('11개의 뉴우런을 사용하여 선형적으로 배열을 만들어 1에서 11까지 라벨링.');
ncenter=11; % 사용할 클러스터 뉴런의 갯수
w=rand(ncenter,2)-0.5*ones(ncenter,2);  % 초기 뉴우런은 특징 공간상에 임의로 위치시킴.

subplot(121),plot(x(:,1),x(:,2),'r.',w(:,1),w(:,2),'*-')
axis([-2 2 -2 2])
title('초기화')
i=1; iter=1; converge=0;
while converge==0,
   dn=ones(ncenter,1)*x(i,:)-w;
   ddn=sum((dn.*dn)')'; % ddn: ncenter by 1
   [tmp,istar]=min(ddn);
   if istar==1,
      w([istar:istar+1],:)=w([istar:istar+1],:)+eta*(ones(2,1)*x(i,:)-w([istar:istar+1],:));
   elseif istar==ncenter,
      w([istar-1:istar],:)=w([istar-1:istar],:)+eta*(ones(2,1)*x(i,:)-w([istar-1:istar],:));
   else
      w([istar-1:istar+1],:)=w([istar-1:istar+1],:)+eta*(ones(3,1)*x(i,:)-w([istar-1:istar+1],:));
   end
   subplot(122),
   plot(x(:,1),x(:,2),'r.',x(i,1),x(i,2),'o',w(:,1),w(:,2),'*-')
   title(['Iteration = ' num2str(iter)])
   drawnow
   i=rem(i+1,N2); iter=iter+1;
   if i==0,
      x=randomize(x);  % 클러스터의 순서를 랜덤하게 섞는다 
      i=1;             % 재배치된 입력으로 시작 
   end
   if rem(iter,50)==0,
      eta=eta*0.9;
      %if isempty(converge), converge=0; end
      if iter >=200, converge=1; end
   end
end
subplot(122),plot(x(:,1),x(:,2),'r.',w(:,1),w(:,2),'*-')
text(w(1,1),w(1,2)+0.2,'1'), text(w(ncenter,1),w(ncenter,2)+0.2,int2str(ncenter))
title(['Iteration = ' num2str(iter)])
axis([-2 2 -2 2])