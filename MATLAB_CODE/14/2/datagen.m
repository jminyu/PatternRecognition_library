function X=datagen(Nvec,mean_var)
% 2D 가우시안 분포 데이터 생성
% Nvec: (1xclass) c개의 가우시안 분포의 각각에 대한 데이터 갯수
% mean_var: (3 x class): 각 클래스에 대하여 처음 2 행은 mean 나머지 1 행은 variance

[m,c]=size(mean_var);
if m ~= 3 | c ~=length(Nvec),
   disp(' dimension not match, break ')
   break
end
X=[];
for i=1:c,   
   randn('seed',sum(100*clock));
   tmp=sqrt(mean_var(3,i))*randn(Nvec(i),2); % scaled by variance
   mean=mean_var(1:2,i);  % mean is a 2 by 1 vector
   X=[X;tmp+ones(Nvec(i),2)*diag(mean)];
end

