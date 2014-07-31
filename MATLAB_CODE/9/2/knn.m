clear all
close all
randn('state',0);
rand('state',0);

Dz = -2:.01:2;
std = 0.5;
pg=normpdf(Dz,0,std);

for (N=100:10:1000)
   D=std*randn(N,1);
   for(K=1:5:N)
      cont=1;
      
      for (z=Dz)
         p(cont)=0;
         d=dist(z,D');
         [s,i]=sort(d);
         p(cont)=K/(N*s(K));
         
         cont=cont+1;
      end
      
      plot(Dz,[p' pg'])
      axis([-2 2 0 2]);
     title(['KNN density estimation: N=' num2str(N) ';K=' num2str(K)])
      pause
   end
end
