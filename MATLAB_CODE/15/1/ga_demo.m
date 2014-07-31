% ������ �˰����� �̿��� ��ȸ �Ǹſ� ����(TSP)�� �ذ�
% N: ������ ��. ���õ��� 1���� N���� �󺧸�. 
clear all
N=input('��ȸ�� ������ ��: ');
%======================================================================
% N���� ���ÿ� ���� TSP ���� ���� 
pos=rand(N,2);  % ���� ���簢������ ������ ��ġ�� ���Ƿ� ���� 
distance=dist(pos,pos); %���ð��� �Ÿ� ���  
figure(1),clf
plot(pos(:,1),pos(:,2),'o') %���� ��ġ ǥ��
axis([0 1 0 1]), axis square, hold on
%�׸��� ���� ��ȣ �󺧸�
for i=1:N
   text(pos(i,1)+.03,pos(i,2),int2str(i));
end
hold off
%========================================================================
% ������ Ž�� 
disp('********** ������ �˰���*****************');
ngen=input('��ȭ��ų �����: ');
ngpool=input('# ������ Ǯ(gene pool)���� ��ü(chromosoms)��: '); % ������ Ǯ�� ũ��
gpool=zeros(ngpool,N); % ������ Ǯ(gene pool)
% ������ Ǯ �ʱ�ȭ 
for i=1:ngpool, 
   gpool(i,:)=[1 randomize([2:N]')'];
end
oldstep=0;
oldcostmin=99999;
costmin=N, tourmin=zeros(1,N); cost=zeros(1,ngpool); 
oldtourmin=gpool(2,:);
%========================================================================
for step=1:ngen, 
   % 1�ܰ�. ���� ��ü�� ���յ� ��, ��ȸ �Ÿ��� ���յ��� �Ǹ� ª������ ����.  
   for i=1:ngpool,
      cost(i)=sum(diag(distance(gpool(i,:)',rshift(gpool(i,:))')));
   end
   % ���� �ֻ��� �н��� ��� 
   [costmin,idx]=min(cost);
   tourmin=gpool(idx,:);
   % 2�ܰ�. ����(crossover)�� ��������(mutation) ���� ���� 
   [csort,ridx]=sort(cost); % ����� �����Ϳ��� ū������ �����Ѵ�. 
   
   for i=2:ngpool/2 
       sameidx=[gpool(2*i-1,:)==gpool(2*i,:)]; 
       diffidx=find(sameidx==0); 
       if length(diffidx)<=2 
           % �������̻���
           gpool(2*i,:)=[1 randomize([2:N]')']; 
       else
           if i%3 == 0 % �κб�ü����
             [gpool(2*i-1,:),gpool(2*i,:)]=PMX(gpool(ridx(2*i-1),:),gpool(ridx(2*i),:));         
           end
           if i%3 == 1  % ��������
             [gpool(2*i-1,:),gpool(2*i,:)]=OX(gpool(ridx(2*i-1),:),gpool(ridx(2*i),:));
           end
           if i%3 == 2 % �ֱⱳ��
             [gpool(2*i-1,:),gpool(2*i,:)]=CX(gpool(ridx(2*i-1),:),gpool(ridx(2*i),:));
           end
       end 
   end 
   
   %pause;
   %������ȸ ��Ʈ�� ���ϴ� �κи� ������ֱ� ���� ó�� 
   sameidx=[oldtourmin==tourmin]; % ���� ������ #1�� ����ũ�� �����                            
   diffidx=find(sameidx==0); % �ٸ� �ε����� ã�Ƽ� 
   if length(diffidx) ~= 0 & costmin < oldcostmin     
       figure;
       plot(pos(:,1),pos(:,2),'o'),axis([0 1 0 1]), axis square, hold on 
       trip=pos(tourmin',:); trip=[trip; trip(1,:)]; 
       plot(trip(:,1),trip(:,2),'-');
       title(['����:' num2str(step) ',  ������ �˻�, ���:' num2str(costmin)])
       hold off;
       drawnow
       disp(['����' num2str(step) '::������ȸ:'  num2str(tourmin)  '::���:'  num2str(costmin) ]);
      oldcostmin = costmin;
      oldtourmin = tourmin;
      oldstep=step;
   end
end

disp(['��� �Լ� �� : ' int2str(ngen*2+ngpool) ' times!'])
disp(['�ּ� ��ȸ �Ÿ� : ' num2str(oldcostmin)])
disp('���� ��ȸ : ') 
disp(num2str(oldtourmin))

figure
plot(pos(:,1),pos(:,2),'o'),axis([0 1 0 1]), axis square, hold on
trip=pos(oldtourmin',:); trip=[trip; trip(1,:)];
plot(trip(:,1),trip(:,2),'-')
title(['����:' num2str(oldstep) ',  ������ �˻�, ���:' num2str(oldcostmin)])
hold off