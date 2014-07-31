function model=mlgauss(data,cov_type)
% MLGAUSS�� �ֿ��������� �־��� �����Ϳ� ���� ����þ� ������ ����Ѵ�. 
% 
% ����:
%  model=mlgauss(data)
%  model=mlgauss(data,cov_type)
% 
% ����:
%  �־��� �����Ϳ� ���� ����þ� ������ �ֿ������� ����Ѵ�. 
%  ML ������ ���� ������ Ǫ�� �Ͱ� ����:
%    (mu^*,C^*)=arg max sum Alpha(x)*log( N(x,mu,C) )
%                        mu,C   x
%  
%  ���⼭ ǥ�� X�� i.i.d. ��� �����Ѵ�. 
%
%  Alpha(x)�� ǥ������ ǥ�� x�� �߻��� �����Ѵ�. (���� Ȯ��)  
%  ����Ʈ�� ��� �����Ϳ� ���Ͽ� 1�̴�. �̷��� ������ ������ ���� ���
%  �˰��򿡼� ������ �쵵 �Լ��� �����Ͽ� ����� �� �����Ѵ�. 
%
%  �Է� �μ� �����ʹ� ������ �ϳ��� �� �� �ִ�.  
%   1) ǥ�� X�� �����ϴ� ��� [dim x num_data] 
%   2) ���� X [dim x num_data],�� y [1 x num_data] 
%           �׸��� ���߰� Alpha [1 x num_data]�� �����ϴ� ����ü 
%      ����, ���� �־����ٸ� ML ������ Ư���� �� Ŭ������ ���Ͽ� ����ȴ�.   
%
%  �����Ǵ� ���л� ����� ���´� ������ ���� ���� �� �� �ִ�:
%     1 ... ���� ���л� ���(Full covariance matrix)
%     2 ... �밢 ���л� ���(Diagonal covariance matrix)
%     3 ... Cov. matrix c*eye(dim,dim). eye(dim,dim): �׵����
%
% �Է� :
%  data [dim x num_data] Data sample.
%  Ȥ�� 
%  data.X [dim x num_data] ������ ����.
%  data.y [1 x num_data] �� (default ones(1,num_data)).
%  data.Alpha [1 x num_data] �������� ���߰� (default ones(1,num_data)).
%
%  cov_type [int] ���л� ����� ���� (defualt 1).
%
% ��� :
%  model.Mu [dim x num_classes] ������ ��� ����.
%  model.C [dim x dim x num_classes] ������ ���л� ���.
%
% Example:
%  help mmgauss;
%
% See also MMGAUSS.
%
% -- Processing of input arguments -----------------------------------

data=c2s(data);

if ~isstruct(data),
   data.X = data;
end

[dim, num_data] = size( data.X );

if ~isfield(data,'y'), data.y = ones(1,num_data); end
if ~isfield(data,'Alpha'), data.Alpha = ones(1,num_data); end

if nargin < 2, cov_type=1; end
  
% -- compute ML estimated for all classes ------
num_classes=max(data.y);

model.Mu = zeros(dim,num_classes);
model.C = zeros(dim,dim,num_classes);

for i=1:num_classes,
   
   inx = find(data.y==i);
   
   Alpha=data.Alpha(inx); Alpha=Alpha(:);
   sum_Alpha = sum(Alpha);
   X = data.X(:,inx);
   num_data = size(X,2);
   
   %------------------------------   
   model.Mu(:,i) = X*Alpha/sum_Alpha;
   
   XC=X-repmat( model.Mu(:,i),1,num_data);

  if cov_type==1,
    % asssumes correlated features
    model.C(:,:,i) = (XC.*(repmat(Alpha',dim,1)))*XC'/(sum_Alpha);
  elseif cov_type==2,
    % asssumes uncorrelated features -> diagonal cov. matrix
    model.C(:,:,i) = diag(sum((XC.*repmat(Alpha',dim,1).*XC)')/(sum_Alpha));
  else
    % asssumes isotropic cov. -> diagonal cov. = c*eye()
    model.C(:,:,i) = eye(dim,dim)*...
      sum(sum((XC.*repmat(Alpha',dim,1).*XC)'))/((sum_Alpha)*dim);
  end
end

model.cov_type = cov_type;
model.y = [1:num_classes];

return; 
