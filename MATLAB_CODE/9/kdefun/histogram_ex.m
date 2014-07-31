%x=rand(1,10)*10; %0-10사이의 랜덤값 1x10 랜덤 벡터를 만든다.
x=[2.3 2.4 2.34 2.41 2.71 2.65 3.34 3.73]
histo(x,0.5,0.5/2,'r-') % histogram을 그린다. 
hold on
%x축에 데이터를 찍어주기 위한 처리
tmp = zeros(1,8);
x1=[x;tmp];
scatter(x1(1,:), x1(2,:), 'rx')
hold off

