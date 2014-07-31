% ========================================================= 
%	LDA (Linear Discriminant Analysis) 시뮬레이션 매트랩 프로그램
%	2004. 2. 3 Han Hag Yong
% 
% 매트랩에 데이터들을 로드한다. 
load class1.dat;
load class2.dat;
load class3.dat;
load data.dat;
load test_data.dat;

% 축소할 차원을 정하는 q를 입력받는다. 
q =input('Input value to reduce to: ');
%q=12;

% 결과를 저장할 파일을 설정한다.
FID = fopen('results','w');

[x,feature_num] = size(data);	 

% 각 클래스에 대한 특징 벡터들의 개수를 구한다. 
[num_test_vectors,x] = size(test_data);
[num_class1_vect,x] = size(class1);
[num_class2_vect,x] = size(class2);
[num_class3_vect,x] = size(class3);

% 전체 데이터 집합과 각 클래스에 대한 평균을 구한다. 
data_mean=mean(data);
class1_mean=mean(class1);
class2_mean=mean(class2);
class3_mean=mean(class3);

% 각 클래스에 대한 within class 공분산(Sw)을 구한다. 
class1_cov=cov(class1);
class2_cov=cov(class2);
class3_cov=cov(class3);

% 전체 데이터에 대하여 between class 공분산(Sb)을 계산한다.
data_cov=cov(data);

%규준계산: 역 class_cov와 between class 공분산을 곱한 새로운 특징 벡터
class1_features=inv(class1_cov)*data_cov;
class2_features=inv(class2_cov)*data_cov;
class3_features=inv(class3_cov)*data_cov;

% 각 클래스에 대한 고유벡터와 고유값을 구한다.(eig 이용)
[eigen_vect_class1, eigen_val_class1]=eig(class1_features);
[eigen_vect_class2, eigen_val_class2]=eig(class2_features);
[eigen_vect_class3, eigen_val_class3]=eig(class3_features);

% 취할 고유 벡터와 버릴 고유벡터를 결정하는 단계이다. 
% 정렬을 위해서 고유값을 저장하기 위해 임시로 1xfeature_num 행렬을 만든다.
for k=1:feature_num	
temp_eigen_val_class1(k) = eigen_val_class1(k,k);	
    temp_eigen_val_class2(k) = eigen_val_class2(k,k);	
    temp_eigen_val_class3(k) = eigen_val_class3(k,k);
end;

% 고유벡터 행렬을 정렬한다. 
for k=1:feature_num						
    [row1,col1] = find(temp_eigen_val_class1 == max(temp_eigen_val_class1));
    ordered_eigen_vect_class1(k,:) = eigen_vect_class1(col1,:);
    temp_eigen_val_class1(col1) = -10000;

    [row2,col2] = find(temp_eigen_val_class2 == max(temp_eigen_val_class2));
    ordered_eigen_vect_class2(k,:) = eigen_vect_class2(col2,:);
    temp_eigen_val_class2(col2) = -10000;

    [row3,col3] = find(temp_eigen_val_class3 == max(temp_eigen_val_class3));
    ordered_eigen_vect_class3(k,:) = eigen_vect_class3(col3,:);
    temp_eigen_val_class3(col3) = -10000;
end;

% 고유벡터 행렬에 대하여 q개의 가장 큰 값을 가진 열만을 가져온다. 

for n=1:q
    transform_class1(n,:) = ordered_eigen_vect_class1(n,:);	%Class1 transform
    transform_class2(n,:) = ordered_eigen_vect_class2(n,:);	%Class2 transform	
    transform_class3(n,:) = ordered_eigen_vect_class3(n,:);	%Class3 transform
end;

%=====================================================================
% 학습 데이터를 각 클래스에 대하여 축소된 특징들을 구한다.  
% 각 클래스에 대하여 For 루프를 사용하여 각 벡터에 대한 축소된 특징들을 찾아서 
% 각 클래스의 벡터들의 수로 나누어서 축소된 각 클래스의 특징들을 평균을 계산한다. 
% 더미 변수가 각 클래스로 부터 벡터를 저장하기 위해서 사용된다. 
% 최종적으로 각 클래스의 임시 벡터을 재초기화한다

% 클래스1에 대한 처리
temp_mean1=0;		%변수 초기화 

for n=1:num_class1_vect
    temp_class1 = class1(n,:);
    reduced_class1_features = transform_class1*transpose(temp_class1);
    reduced_class1_features = transpose(reduced_class1_features);
    temp_mean1 = temp_mean1 + reduced_class1_features;
    temp_class1 = 0;
end;

% 클래스1 벡터들의 수로 temp_mean을 나눔으로서 축소된 클래스1 특징들의 평균을 계산한다. 
mean_reduced_class1_features = temp_mean1/num_class1_vect;

% 클래스2 에 대한 처리
temp_mean2=0;		%변수 초기화 

for n=1:num_class2_vect
    temp_class2 = class2(n,:);
    reduced_class2_features = transform_class2*transpose(temp_class2);
    reduced_class2_features = transpose(reduced_class2_features);
    temp_mean2 = temp_mean2 + reduced_class2_features;
    temp_class2 = 0;
end;

% 클래스2 벡터들의 수로 temp_mean을 나눔으로서 축소된 클래스2 특징들의 평균을 계산한다. 
mean_reduced_class2_features = temp_mean2/num_class2_vect;

% 클래스3 에 대한 처리
temp_mean3=0;		%변수 초기화 

for n=1:num_class3_vect
    temp_class3 = class3(n,:);
    reduced_class3_features = transform_class3*transpose(temp_class3);
    reduced_class3_features = transpose(reduced_class3_features);
    temp_mean3 = temp_mean3 + reduced_class3_features;
    temp_class3 = 0;
end;

% 클래스3 벡터들의 수로 temp_mean을 나눔으로서 축소된 클래스3 특징들의 평균을 계산한다. 
mean_reduced_class3_features = temp_mean3/num_class3_vect;

%==============================================================
% 테스터

% test_feature는 HSBE, MSBE, or LSBE인지를 테스터될 특징벡터이다.  

for j=1:num_test_vectors	%테스터 특징 벡터들에 대한 for 루프 시작
temp_test_feature_vect = test_data(j,:);

%	CLASS 1
reduced_test_feature_vect_class1 
= transform_class1*transpose(temp_test_feature_vect);
reduced_test_feature_vect_class1 
= transpose(reduced_test_feature_vect_class1);
class1_distance 
= reduced_test_feature_vect_class1 - mean_reduced_class1_features;

%	CLASS 2
reduced_test_feature_vect_class2 
= transform_class2*transpose(temp_test_feature_vect);
reduced_test_feature_vect_class2 
= transpose(reduced_test_feature_vect_class2);
class2_distance 
= reduced_test_feature_vect_class2 - mean_reduced_class2_features;

%	CLASS 3
reduced_test_feature_vect_class3 
= transform_class3*transpose(temp_test_feature_vect);
reduced_test_feature_vect_class3 
= transpose(reduced_test_feature_vect_class3);
class3_distance 
= reduced_test_feature_vect_class3 - mean_reduced_class3_features;

% 각 클래스에 대한 거리의 크기를 찾는다. 
mag_class1_distance =0;
mag_class2_distance =0;
mag_class3_distance =0;

for n=1:q
    squared1 = class1_distance(n) * class1_distance(n);
    mag_class1_distance = mag_class1_distance + squared1; %거리의 크기을 찾는다.
    
    squared2 = class2_distance(n) * class2_distance(n);		     
    mag_class2_distance = mag_class2_distance + squared2; %거리의 크기을 찾는다.

    squared3 = class3_distance(n) * class3_distance(n);
    mag_class3_distance = mag_class3_distance + squared3; %거리의 크기을 찾는다.
end;
 

% 테스트 데이터가 어느 클래스에 속하는지의 결정은 최소거리을 통해서 결정한다.  
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
end; % 특징 벡터들의 수만큼 루프를 돌린 for 문의 끝
fclose all;

