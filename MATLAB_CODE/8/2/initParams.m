% [mus, sigmas, weights] = initParams(d,M);
%
% trainGMM���� ���� ������ �Ķ���� ������ �����Ѵ�. 
%
% �Է� ���� :
% d : ����
% M : �ͽ��� ������ ����
%
% ��� ���� : 
% mus -> means: "0" ������ �����ϰ� �����ȴ�.  
% sigmas -> covariances: ��� ������ ���� ���л�(1)��  ���
% weights -> weights: ���� ���� ���߰�

function [mus, sigmas, weights] = initParams(d,M);

  mus = rand(d,M)-0.5;
  sigmas = ones(d,M);
  weights = ones(M,1)/M;
