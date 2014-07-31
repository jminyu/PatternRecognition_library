% 이 스크립트를 호출한 후, 각 픽셀이 정방형이 되도록 윈도우 창을 조정하시요

colormap('gray');
pat = zeros(6,5);

for patNum = 1:nPats,
  pat(1:5,1:4) = reshape(input(:,patNum),4,5)';
  axis off, subplot(10,4,patNum), pcolor(pat);
end