% 모든 변수들과 그림들을 지운다. 
  clear all;
  close all;

% 타원모양의 분포를 가진느 데이터 점들을 생성시킨다. 
  x(1,:) = randn(1,100);
  x(2,:) = randn(1,100)*3;

% 보여주기 위해 타원 모양 데이터 분포를 회전한다. 
  [p(1,:),p(2,:)] = cart2pol(x(1,:),x(2,:));
  p(1,:) = p(1,:)-pi/3;
  [x(1,:),x(2,:)] = pol2cart(p(1,:),p(2,:));

% 데이터를 플롯한다. 
  scatter(x(1,:),x(2,:));
  axis equal;
  drawnow;
  pause;

% 주성분(PC)을 계산하다. 
  [pc, latent, explained] = pcacov(cov(x'));

% 데이터 상에 주성분을 그린다. 
  hold on;
  plot([-4 4]*pc(1,1),[-4 4]*pc(2,1),'r-');
  plot([-2 2]*pc(1,2),[-2 2]*pc(2,2),'g-');
  pause;

% 주성분을 축으로 데이터를 회전한다.
  y = (x'*pc)';

% 데이터를 플롯한다. 
  figure;
  scatter(y(1,:),y(2,:));
  axis equal;
  drawnow;
  pause;

% 축상으로 주성분이 놓여있는가를 확인하기 위해서 다시 주성분(PC)을 계산한다. 
  [pc2, latent, explained] = pcacov(cov(y'));

% 데이터 상에 주성분을 그린다.
  hold on;
  plot([-4 4]*pc2(1,1),[-4 4]*pc2(2,1),'r-');
  plot([-2 2]*pc2(1,2),[-2 2]*pc2(2,2),'g-');
  pause;

% 일차원으로 축소하기 두번째 성분을 0으로 설정한다. 
  y(2,:) = 0;

% 원 데이터를 역변환한다. 
  x = (y'*inv(pc))';

% 데이터를 플롯한다. 
  figure;
  scatter(x(1,:),x(2,:));
  axis equal;
  drawnow;
  pause;

% 완성
  close all;
