% �� ��ũ��Ʈ�� ȣ���� ��, �� �ȼ��� �������� �ǵ��� ������ â�� �����Ͻÿ�

colormap('gray');
pat = zeros(6,5);

for patNum = 1:nPats,
  pat(1:5,1:4) = reshape(input(:,patNum),4,5)';
  axis off, subplot(10,4,patNum), pcolor(pat);
end