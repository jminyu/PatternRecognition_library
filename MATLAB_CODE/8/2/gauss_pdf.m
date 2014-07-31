% p=gauss_pdf(x,mu,sigma);
%
% 입력 벡터 x에 대하여 구해진 MU와 SIGMA에 의하여 지정된 다변량 가우시안 pdf 
% 값을 리턴.  

function p=gauss_pdf(x,mu,sigma);

d = length(x);
if size(x,1) ~= d
  x = x';
end

if (length(mu) == d) == 0
   error('Dimension of mean vector mu should be the same as that of input vector x');
end

if size(mu,1) ~= d
  mu = mu';
end

if (size(sigma) == [d,d]) == 0
   error('Covariance matrix sigma should be square, with dimension the same as that of input vector x');
end

detsig = det(sigma);

if detsig == 0 
  error('Covariance matrix sigma is singular!')
end

xx = x-mu;
p = exp(-0.5*xx'*inv(sigma)*xx)/(sqrt(detsig)*(2*pi)^(d/2));
