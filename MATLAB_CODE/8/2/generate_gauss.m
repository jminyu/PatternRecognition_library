% X = generate_gauss(muvec,covmat,numpoints);
%
% numpoints 개수 만큼의 특징 벡터 데이터 집합을 생성. 
% 각각의 데이터는 지정한 가우시안 분포를 따른다. 
%
% 입력 인자:
% muvec: d-차원의 평균 벡터
% covmat: d*d 공분산 행렬
%
% 출력 인자:
% X는 행이 d차원의 특징벡터인 데이터 행렬이다. 

function X = generate_gauss(muvec,covmat,numpoints);

d = length(muvec);
if (size(covmat) == [d,d]) == 0
   error('Incompatible dimensions!');
end

X = inv(whiten(covmat)') * randn(d,numpoints) + muvec'*ones(1,numpoints);
