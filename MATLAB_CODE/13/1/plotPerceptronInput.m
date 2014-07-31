% 3차원 입력 패턴을 플롯한다. 
% 패턴의 처음 절반은 원(o)으로 표시되고, 나머지 절반은 별표(*)로 표시된다. 
plot3(input(1,mid+1:nPats),input(2,mid+1:nPats),input(3,mid+1:nPats),'c*')
plot3(input(1,1:mid),input(2,1:mid),input(3,1:mid),'mo')