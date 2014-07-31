function X=datagen(Nvec,mean_var)
% 2D ����þ� ���� ������ ����
% Nvec: (1xclass) c���� ����þ� ������ ������ ���� ������ ����
% mean_var: (3 x class): �� Ŭ������ ���Ͽ� ó�� 2 ���� mean ������ 1 ���� variance

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

