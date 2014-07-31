clear all
close all
randn('state',0);
rand('state',0);

Dz = -2:.01:2;
std = 0.5;
pg=normpdf(Dz,0,std);

for (N=100:10:1000)
   D=std*randn(N,1);
   for(B=0.1:0.5:10)
      cont=1;
      
      for (z=Dz)
         p(cont)=0;
         for (i=1:N)
            B_N = B/sqrt(N);
            p(cont)=p(cont)+phi((z-D(i))/B_N);
         end
         p(cont)=p(cont)/(B_N*N);
         cont=cont+1;
      end
      plot(Dz,[p' pg'])
      axis([-2 2 0 2]);
      title(['Parzen WINDOW method: N=' num2str(N) ';B_N=' num2str(B_N)])
      pause
      %drawnow;
   end
end