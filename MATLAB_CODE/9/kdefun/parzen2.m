clear all
close all
randn('state',0);
rand('state',0);
m=3;
N=500;
mix=[0.8 0.1 0.1];

mu=[-1; 0; 1];
stdg=[0.3;0.2;0.1];

for (N=100:10:1000)
    
    for i=1:N
        a=rand;
        
        if (a<mix(1))
            D(i,1)=mu(1)+stdg(1)*randn;
        elseif (a >= mix(1) & a < sum(mix(1:2)))
            D(i,1)=mu(2)+stdg(2)*randn;
        else 
            D(i,1)=mu(3)+stdg(3)*randn;
        end
    end
    
    
    Dz=-2:.01:2;
    pg=zeros(size(Dz));
    for (i=1:m)
        pg=pg+mix(i)*normpdf(Dz,mu(i),stdg(i));
    end
    
    for (B=0.1:.5:10)
        cont=1;
        
        
        for (z=Dz)
            p(cont)=0;
            B_N=B/sqrt(N);
            for (i=1:N)
                p(cont)=p(cont)+phi((z-D(i))/B_N);
            end
            p(cont)=p(cont)/(B_N*N);
            cont=cont+1;
        end
        
        plot(Dz,[p' pg'])
        axis([-2 2 0 2])
        title(['N=' num2str(N) ';B_N=' num2str(B_N)])
        pause
    end
end
