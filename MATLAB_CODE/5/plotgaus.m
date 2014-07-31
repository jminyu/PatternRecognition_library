function [h] = plotgaus( mu, sigma, colspec );

% PLOTGAUS 가우시안 컨투어 그려보기
%
%    PLOTGAUS(MU,SIGMA,COLSPEC)
%    MU : 평균 
%    SIGMA : 공분산
%    색깔지정인자 COLSPEC = [R,G,B].
%    PLOTGAUS(MU,SIGMA)일 경우, 디폴트 색상은 [0 1 1] (cyan).
%

if nargin < 3; colspec = [0 1 1]; end;
npts = 100;

stdev = sqrtm(sigma);

t = linspace(-pi, pi, npts);
t=t(:);

X = [cos(t) sin(t)] * stdev + repmat(mu,npts,1);

h(1) = line(X(:,1),X(:,2),'color',colspec,'linew',2);
h(2) = line(mu(1),mu(2),'marker','+','markersize',10,'color',colspec,'linew',2);

