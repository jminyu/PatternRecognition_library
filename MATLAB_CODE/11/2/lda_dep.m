% ==================================================================== 
%	Ŭ���� ����-LDA (Linear Discriminant Analysis) �ùķ��̼� ���α׷�
% ====================================================================
clear all
% �����͵��� �ε��Ѵ�. 
load class1.dat;
load class2.dat;
load class3.dat;
load data.dat; % data.dat = class1.dat + class2.dat + class3.dat
load test_data.dat;

% ����� ������ ���ϴ� q �� �Է¹޴´�. 
q =input('Input value to reduce to: ');

% ����� ������ ������ �����Ѵ�.
FID = fopen('results','w');

[x,feature_num] = size(data);	 

% Ư¡ ���͵��� ���� ��´�.
[num_test_vectors,x] = size(test_data);
[num_class1_vect,x] = size(class1);
[num_class2_vect,x] = size(class2);
[num_class3_vect,x] = size(class3);

% �� ������ ���հ� �� Ŭ������ ����� ����Ѵ�.
data_mean=mean(data);
class1_mean=mean(class1);
class2_mean=mean(class2);
class3_mean=mean(class3);

% �� Ŭ������ ���� Ŭ������ �л�(Sw)�� ����Ѵ�.
class1_cov=cov(class1);
class2_cov=cov(class2);
class3_cov=cov(class3);

% Ŭ������ �л�(Sb)�� ����Ѵ�.
data_cov=cov(data);

% �� Ŭ������ �� ���л� ���(class_cov)�� Ŭ������ �л��� ���� ���ο� Ư¡ ���͸� ����Ѵ�.
class1_features=inv(class1_cov)*data_cov;
class2_features=inv(class2_cov)*data_cov;
class3_features=inv(class3_cov)*data_cov;

% �� Ŭ������ ���� �������Ϳ� �������� ã�´�.(eig �̿�)
[eigen_vect_class1, eigen_val_class1]=eig(class1_features);
[eigen_vect_class2, eigen_val_class2]=eig(class2_features);
[eigen_vect_class3, eigen_val_class3]=eig(class3_features);

eigen_vect_all = [eigen_vect_class1; eigen_vect_class2; eigen_vect_class3];  

% ���� ���� ���Ϳ� ���� �������͸� �����Ѵ�.
% ���� �ڵ�� �ӽ÷� ������ ����� �밢�������κ��� �����ϱ� ���� 
% �ӽ÷� ������ ���� 1xfeature_num ����� �����.
for k=1:feature_num	
    temp_eigen_val_all(k) = eigen_val_class1(k,k);	
end;
for k=1:feature_num	
    temp_eigen_val_all(k+feature_num) = eigen_val_class2(k,k);	
end;
for k=1:feature_num	
    temp_eigen_val_all(k+2*feature_num) = eigen_val_class3(k,k);
end;

% �ӽ� ������ ��ķκ��� �������� ��ĸ� �����Ѵ�.
for k=1:2*feature_num						
    [row,col] = find(temp_eigen_val_all == max(temp_eigen_val_all));
    ordered_eigen_vect_all(k,:) = eigen_vect_all(col,:);
    temp_eigen_val_class1(col) = -10000;
end;

% ���ĵ� �������� ��Ŀ��� ����� q���� ��ȯ ����� ����� 
for n=1:q
    transform_class_all(n,:) = ordered_eigen_vect_all(n,:);		
end;

%========================================================================
% �� Ŭ������ �н� �����͸� ��ȯ ����� ���Ͽ� ����Ѵ�. 
% �׸��� ��ҵ� Ư¡ ������ ����� ���Ѵ�. 

% Ŭ����1
temp_mean1=0;		%���� �ʱ�ȭ 
for n=1:num_class1_vect
    temp_class1 = class1(n,:);
    reduced_class1_features = transform_class_all*transpose(temp_class1);
    reduced_class1_features = transpose(reduced_class1_features);
    temp_mean1 = temp_mean1 + reduced_class1_features;
    temp_class1 = 0;
end;
% Ŭ����1 Ư¡���� ����� ����Ѵ�. 
mean_reduced_class1_features = temp_mean1/num_class1_vect;

% Ŭ����2
temp_mean2=0;		%���� �ʱ�ȭ 
for n=1:num_class2_vect
    temp_class2 = class2(n,:);
    reduced_class2_features = transform_class_all*transpose(temp_class2);
    reduced_class2_features = transpose(reduced_class2_features);
    temp_mean2 = temp_mean2 + reduced_class2_features;
    temp_class2 = 0;
end;
% Ŭ����2 Ư¡���� ����� ����Ѵ�. 
mean_reduced_class2_features = temp_mean2/num_class2_vect;

% Ŭ����3
temp_mean3=0;		%���� �ʱ�ȭ 
for n=1:num_class3_vect
    temp_class3 = class3(n,:);
    reduced_class3_features = transform_class_all*transpose(temp_class3);
    reduced_class3_features = transpose(reduced_class3_features);
    temp_mean3 = temp_mean3 + reduced_class3_features;
    temp_class3 = 0;
end;
% Ŭ����3 Ư¡���� ����� ����Ѵ�. 
mean_reduced_class3_features = temp_mean3/num_class3_vect;


%==============================================================
%	�׽�Ʈ
for j=1:num_test_vectors	%�׽��� Ư¡ ���͵鿡 ���� for ���� ����
  temp_test_feature_vect = test_data(j,:);

%	CLASS 1
reduced_test_feature_vect_class1 = transform_class_all*transpose(temp_test_feature_vect);
reduced_test_feature_vect_class1 = transpose(reduced_test_feature_vect_class1);
class1_distance = reduced_test_feature_vect_class1 - mean_reduced_class1_features;

%	CLASS 2
reduced_test_feature_vect_class2 = transform_class_all*transpose(temp_test_feature_vect);
reduced_test_feature_vect_class2 = transpose(reduced_test_feature_vect_class2);
class2_distance = reduced_test_feature_vect_class2 - mean_reduced_class2_features;

%	CLASS 3
reduced_test_feature_vect_class3 = transform_class_all*transpose(temp_test_feature_vect);
reduced_test_feature_vect_class3 = transpose(reduced_test_feature_vect_class3);
class3_distance = reduced_test_feature_vect_class3 - mean_reduced_class3_features;

% �� Ŭ������ ���� �Ÿ��� ũ�⸦ ã�´�. 
mag_class1_distance =0;
mag_class2_distance =0;
mag_class3_distance =0;

for n=1:q
    squared1 = class1_distance(n) * class1_distance(n);
    mag_class1_distance = mag_class1_distance + squared1; %�Ÿ��� ũ���� ã�´�.
    
    squared2 = class2_distance(n) * class2_distance(n);		     
    mag_class2_distance = mag_class2_distance + squared2; %�Ÿ��� ũ���� ã�´�.

    squared3 = class3_distance(n) * class3_distance(n);
    mag_class3_distance = mag_class3_distance + squared3; %�Ÿ��� ũ���� ã�´�.
end;
 

% �׽�Ʈ �����Ͱ� ��� Ŭ������ ���ϴ����� ������ �ּҰŸ��� ���ؼ� �����Ѵ�.  
distance_vect=[mag_class1_distance, mag_class2_distance, mag_class3_distance];
if min(distance_vect)==distance_vect(1)
   fprintf(FID,'Class 1\n');
end;
if min(distance_vect)==distance_vect(2)
   fprintf(FID,'Class 2\n');
end;
if min(distance_vect)==distance_vect(3)
   fprintf(FID,'Class 3\n');
end;
end; % Ư¡ ���͵��� ����ŭ ������ ����  for ���� ��

fclose all;