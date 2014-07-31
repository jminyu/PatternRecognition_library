R1 =   rand(1000,2);
figure;
plot(R1(:,1), R1(:,2), 'r*');
axis('square');
title('uniformly distributed random vectors');
ylabel('y');
xlabel('x');

pause

R1_Mean = [mean(R1(:,1)), mean(R1(:,2))];
Rctr = [R1(:,1) - R1_Mean(:,1) , R1(:,2) - R1_Mean(:,2)];
figure;
plot(Rctr(:,1), Rctr(:,2), 'r*');
axis('square');
title('uniformly distributed random vectors-평균이 0이 되도록 재배치');
ylabel('y');
xlabel('x');


pause

for i = 1 : 1000   
   if ( (sqrt(Rctr(i,1)^2 + Rctr(i,2)^2)) > 0.5)
       for j = 1 : 2
           Rcirc(i,j) = 0;
       end
   else 
       for j = 1 : 2
         Rcirc(i,j) = Rctr(i,j);
       end
   end
end

plot(Rcirc(:,1), Rcirc(:,2), 'r*');

pause

N = 1000
a = 0;
for i = 1 : N  
a = a + Rcirc(i,1)^2;
end 
a = a / N;

b = 0;
for i = 1 : N  
b = b + Rcirc(i,1)*Rcirc(i,2);
end 
b = b / N;

c = 0;
for i = 1 : N  
c = c + Rcirc(i,2)^2;
end 

c = c / N;

C = [a b;b c]


pause

[Evect, Eval] = eig(C);

Evect
Eval


