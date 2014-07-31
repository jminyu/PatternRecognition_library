M=[0 5 3 1 0; 4 4 5 0 2; 6 1 2 18 2; 7 10 9 6 21; 3 6 4 9 5]

[r,c] = size(M);
% costs
D = zeros(r+1, c+1);
D(1,:) = NaN;
D(:,1) = NaN;
D(1,1) = 0;
D(2:(r+1), 2:(c+1)) = M;


% traceback
phi = zeros(r,c);

for i = 1:r; 
  for j = 1:c;
    [dmax, tb] = max([D(i, j), D(i, j+1), D(i+1, j)]); %최대값 선택
    %[dmax, tb] = min([D(i, j), D(i, j+1), D(i+1, j)]); %최소값 선택
    D(i+1,j+1) = D(i+1,j+1)+dmax;
    phi(i,j) = tb;
  end
end

D
phi
