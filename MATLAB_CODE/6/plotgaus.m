function [h] = plotgaus( mu, sigma, colspec );

% PLOTGAUS ����þ� ������ �׷�����
%
%    PLOTGAUS(MU,SIGMA,COLSPEC)
%    MU : ��� 
%    SIGMA : ���л�
%    ������������ COLSPEC = [R,G,B].
%    PLOTGAUS(MU,SIGMA)�� ���, ����Ʈ ������ [0 1 1] (cyan).
%

if nargin < 3; colspec = [0 1 1]; end;
npts = 100;

stdev = sqrtm(sigma);

t = linspace(-pi, pi, npts);
t=t(:);

X = [cos(t) sin(t)] * stdev + repmat(mu,npts,1);

h(1) = line(X(:,1),X(:,2),'color',colspec,'linew',2);
h(2) = line(mu(1),mu(2),'marker','+','markersize',10,'color',colspec,'linew',2);

