function [hh] = plot_gaussian(covar,mu,col,n)

if ~isempty(find(covar-covar == 0))

  if size(mu,1) < size(mu,2), mu = mu'; end

  if size(covar,1) == 3

    theta = (0:1:n-1)'/(n-1)*pi;
    phi = (0:1:n-1)/(n-1)*2*pi;
    
    sx = sin(theta)*cos(phi);
    sy = sin(theta)*sin(phi);
    sz = cos(theta)*ones(1,n);
    
    svect = [reshape(sx,1,n*n); reshape(sy,1,n*n); reshape(sz,1,n*n)];
    epoints = sqrtm(covar) * svect + mu*ones(1,n*n);
    
    ex = reshape(epoints(1,:),n,n);
    ey = reshape(epoints(2,:),n,n);
    ez = reshape(epoints(3,:),n,n);
    
    colourset = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1];
    colour = colourset(mod(col-1,size(colourset,1))+1,:);      
    hh = mesh(ex,ey,ez, reshape(ones(n*n,1)*colour,n,n,3) );
    hidden off
    light

% EPS 형식으로 지정된 파일에 저장할 수 있게 바꾸기위해서는
% 'mesh' 명령은 해상도를 올려 그려주어야 한다. 이 경우에는 위의 5줄 대신 다응� 4줄을 사용할 것
%    colourset = ['r'; 'g'; 'b'; 'y'; 'm'; 'c']; 
%    colour = colourset(mod(col-1,size(colourset,1))+1,:);
%    plot3(epoints(1,:),epoints(2,:),epoints(3,:),colour)
%    plot3(reshape(ex',1,n*n),reshape(ey',1,n*n),reshape(ez',1,n*n),colour)
  else
    
    theta = (0:1:n-1)/(n-1)*2*pi;
    
    epoints = sqrtm(covar) * [cos(theta); sin(theta)] + mu*ones(1,n);
    
    colourset = ['r'; 'g'; 'b'; 'y'; 'm'; 'c']; 
    colour = colourset(mod(col-1,size(colourset,1))+1,:);
    
    hh = plot(epoints(1,:),epoints(2,:),colour,'LineWidth',3);
    plot(mu(1,:),mu(2,:),[colour '.'])
    
  end

else
  fprintf('\n공분산 행렬이 좋지 않아 그려줄수가 없네요\n')
end
