clear all
close all
clc

% �н� �̹����� ����
M=25;

% ������ ���� ���(mean)�� ǥ������(std)�� ���Ƿ� ����. 
um=100;
ustd=80;

% �н� �̹��� �ε��� �����ֱ� 
S=[];    % �н� �̹��� ���� ��� 
figure(1);
for i=1:M
  str=strcat(int2str(i),'.bmp');    % �̹����� �̸��� ����� ���ڿ� ó�� 
  eval('img=imread(str);');
  subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
  imshow(img)
  if i==3
    title('�н� �󱼿��� ����','fontsize',12)
  end
  drawnow;
  [irow icol]=size(img); % �̹����� ��(rows : N1)�� �� (columns : N2)�� ��´�. 
  temp=reshape(img',irow*icol,1);    % 1���� ���ͷ� �����. (N1*N2)x1 
  S=[S temp];    % S ��Ŀ� ��� �����Ѵ�. ��������� N1*N2xM ����� �ȴ�. 
end

% ���� ��濡 ���Ͽ� �߻��ϴ� ������ ���̱� ������
% ������ ��հ� �л��� �������� ��� �̹����� ����ȭ�Ѵ�. 
for i=1:size(S,2)
  temp=double(S(:,i));
  m=mean(temp);
  st=std(temp);
  S(:,i)=(temp-m)*ustd/st+um;
end

% ����ȭ�� �̹����� �����ش�. 
figure(2);
for i=1:M
  str=strcat(int2str(i),'.jpg');
  img=reshape(S(:,i),icol,irow);
  img=img';
  eval('imwrite(img,str)'); 
  subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
  imshow(img)
  drawnow;
  if i==3
    title('����ȭ�� �н� �󱼿��� ����','fontsize',12)
  end
end

% ��վ� ��� 
m=mean(S,2);  % �� ���� ��� ���. 
tmimg=uint8(m); % unsigned 8-bit integer�� ��ȯ�ϸ� ������ 0���� 255 ������ ���� ���´�. 
img=reshape(tmimg,icol,irow); % N1*N2x1 ������ N1xN2 ��ķ� �������Ѵ�. 
img=img'; 
figure(3);
imshow(img);
title('��վ�','fontsize',12)

% ������ �м��� ���ؼ� �̹��� ���� 
dbx=[];    % A ��� ���� �迭
for i=1:M
  temp=double(S(:,i));
  dbx=[dbx temp];
end

%���л� ���(Covariance matrix) C=A'A, L=AA'
A=dbx';
L=A*A';
% vv�� L�� ��������(eigenvector)  
% dd�� L=dbx'*dbx �� C=dbx*dbx'�� ���� ������(eigenvalue). 
[vv dd]=eig(L);
% �����Ͽ� �������� ������ ���� ���� 
v=[];
d=[];
for i=1:size(vv,2)
  if(dd(i,i)>1e-4)
    v=[v vv(:,i)];
    d=[d dd(i,i)];
  end
end

%�ø��������� ���� 
[B index]=sort(d);
ind=zeros(size(index));
dtemp=zeros(size(index));
vtemp=zeros(size(v));
len=length(index);
for i=1:len
   dtemp(i)=B(len+1-i);
   ind(i)=len+1-index(i);
   vtemp(:,ind(i))=v(:,i);
end
d=dtemp;
v=vtemp;

%���������� ����ȭ 
for i=1:size(v,2) %�� ���� ���Ͽ� 
   kk=v(:,i);
   temp=sqrt(sum(kk.^2));
   v(:,i)=v(:,i)./temp;
end

%C����� �������͵� 
u=[];
for i=1:size(v,2)
   temp=sqrt(d(i));
   u=[u (dbx*v(:,i))./temp];
end

%���������� ����ȭ 
for i=1:size(u,2)
   kk=u(:,i);
   temp=sqrt(sum(kk.^2));
   u(:,i)=u(:,i)./temp;
end

% ������ �����ֱ�
figure(4);
for i=1:size(u,2)
  img=reshape(u(:,i),icol,irow);
  img=img';
  img=histeq(img,255);
  subplot(ceil(sqrt(M)),ceil(sqrt(M)),i)
  imshow(img)
  drawnow;
  if i==3
    title('������','fontsize',12)
  end
end

% �н� �󱼿��� ���տ��� �� ���� ����ġ�� ��� 
omega = [];
for h=1:size(dbx,2)
  WW=[]; 
  for i=1:size(u,2)
    t = u(:,i)'; 
    WeightOfImage = dot(t,dbx(:,h)');
    WW = [WW; WeightOfImage];
  end
  omega = [omega WW];
end

% �� �̹����� ���ͼ�
% �Է� ���� ������ bmp Ȥ�� jpg ���� 

InputImage = input('�ν��� ���� ���ϸ�� Ȯ���ڸ� �Է��ϼ��� \n','s');
InputImage = imread(strcat('F:\',InputImage));
figure(5)
subplot(1,2,1)
imshow(InputImage); colormap('gray');title('�Է� ����','fontsize',18)
InImage=reshape(double(InputImage)',irow*icol,1); 
temp=InImage;
me=mean(temp);
st=std(temp);
temp=(temp-me)*ustd/st+um;
NormImage = temp;
Difference = temp-m;

p = [];
aa=size(u,2);
for i = 1:aa
  pare = dot(NormImage,u(:,i));
  p = [p; pare];
end

ReshapedImage = m + u(:,1:aa)*p; % m�� ��տ���, u�� ������
ReshapedImage = reshape(ReshapedImage,icol,irow);
ReshapedImage = ReshapedImage';

%�籸���� �̹��� ���̱� 
subplot(1,2,2)
imagesc(ReshapedImage); colormap('gray');
title('�籸�� ����','fontsize',12)

InImWeight = [];
for i=1:size(u,2)
  t = u(:,i)';
  WeightOfInputImage = dot(t,Difference');
  InImWeight = [InImWeight; WeightOfInputImage];
end

ll = 1:M;
figure(68)
subplot(1,2,1)
stem(ll,InImWeight)
title('�Է¾��� ����ġ','fontsize',12)

% Euclidean �Ÿ��� ���Ѵ�. 
e=[];
for i=1:size(omega,2)
  q = omega(:,i);
  DiffWeight = InImWeight-q;
  mag = norm(DiffWeight);
  e = [e mag];
end

kk = 1:size(e,2);
subplot(1,2,2)
stem(kk,e)
title('�Է¿��� ���� ��Ŭ����� �Ÿ�','fontsize',12)

MaximumValue=max(e)  % �ִ� ��Ŭ����� �Ÿ�
MinimumValue=min(e)   % �ּ� ��Ŭ����� �Ÿ�