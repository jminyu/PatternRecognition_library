%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simple demo of Gentle Boost with stumps and 2D data
% Implementation of gentleBoost. The algorithm is described in:
% Jeong-Hyun, Kim 
% V.I.S. Lab.
% vis.me.pusan.ac.kr
 
clear all
clc;
% Define plot style parameters
plotstyle.colors = {'g*', 'r+'};  % color for each class
plotstyle.range = [-50 50 -50 50]; % data range
 
 
% Create data: use the mouse to build the training dataset.
figure(1); 
clf %clear current figure window
axis(plotstyle.range); hold on
axis('square')
title('Left button = class +1, right button = class -1. Press any key to finish.')
i  = 0; clear X Y
 
while 1
    [x,y,c] = ginput(1);
    if ismember(c, [1 3])
        i = i + 1;
        X(1,i) = x;
        X(2,i) = y;
        Y(i) = (c==1) - (c==3); % class = {-1, +1}
        plot(x, y, plotstyle.colors{(Y(i)+3)/2}, 'MarkerFaceColor', plotstyle.colors{(Y(i)+3)/2}(1), 'MarkerSize', 8);
    else
        break
    end
end
 
[Nfeatures, Nsamples] = size(X); 
%% make weight
D = ones(1,Nsamples) / Nsamples;
 
%%Line Classifier Feature 
%% x Axis data
sortX = sort(X(1,:));
WeakData = ones(1,3); %location parity
WeakCount = 1;
for j=1:Nsamples-1
    WeakData(WeakCount,:) = [1, ( sortX(j)+sortX(j+1) )/2, +1];
    WeakCount = WeakCount + 1;
    WeakData(WeakCount,:) = [1, ( sortX(j)+sortX(j+1) )/2, -1];
    WeakCount = WeakCount + 1;
end
 
%%% y Axis data
sortY = sort(X(2,:));
for j=1:Nsamples-1
    WeakData(WeakCount,:) = [2, ( sortY(j)+sortY(j+1) )/2, +1];
    WeakCount = WeakCount + 1;
    WeakData(WeakCount,:) = [2, ( sortY(j)+sortY(j+1) )/2, -1];
    WeakCount = WeakCount + 1;
end
WeakCount = WeakCount - 1;
disp( sprintf('Feature 개수는 : %d', WeakCount) );
%%
%반복횟수
T = 50;
 
%T개의 특징과 알파
TrainWeak = ones(1,2);
 
%%
for tIndex=1:T
%%% find lowest error using Weak Classifier
tTError=[0];
for j=1:WeakCount
    Error=0;
    %%calculate jth feature error value.
    for k=1:Nsamples
        %%Xleft +1 -1?
        if(WeakData(j,2) >  X(WeakData(j,1),k))
            if(WeakData(j,3) ~= Y(k) ) 
                %add wrong error
                Error = Error + D(1,k);
            end
        else
            if( WeakData(j,3)*-1 ~= Y(k) )
                %add wrong error
                Error = Error + D(1,k);
            end
        end
    end
    tTError(j)=[ Error];
end
 
 
[sortTError,sortIndex]=sort(tTError);
 
%calculate alpha using lowest error
alpha = 0.5 * log( (1-sortTError(1,1)) / sortTError(1,1) ) ;
 
%save alpha, weakclassifer
TrainWeak(tIndex, :) = [sortIndex(1,1),alpha];
 
tTError
sortTError
sortIndex
alpha
 
%weight update
for j=1:Nsamples
    %%Xleft +1?
    if(WeakData(sortIndex(1,1),2) >  X(WeakData(sortIndex(1,1),1),j))
        if(WeakData(sortIndex(1,1),3) ~= Y(j) ) 
            %wrong 
            D(1,j) = D(1,j) * exp(alpha);
        else
            %right
            D(1,j) = D(1,j) * exp(-alpha);
        end
    else
        if( WeakData(sortIndex(1,1),3)*-1 ~= Y(j) )
            %add wrong
            D(1,j) = D(1,j) * exp(alpha);
        else
            %add right
            D(1,j) = D(1,j) * exp(-alpha);
        end
    end
end
 
disp( sprintf('%d 번째', tIndex));
disp( sprintf('error %f', sortTError(1,1) ));
disp( sprintf('alpha %f' ,alpha));
disp( sprintf('z %f' , sum(D) ));
 
D = D / sum(D);
disp(D);
disp('============================ next round ==========================================')
end
 
 
%% start all data
%make data
inData = [-50:50 ; ones(1,101)*50 ];
for i=-49:50
    temp = [-50:50 ; ones(1,101)*i ];
    inData = [inData , temp];
end
 
[c,s] = size(inData);
inDataResult = ones(1,s); %+1 or -1 result
 
 
%jth 
for j=1:s
H=0;
A=0;
Sigma=0;
 
for i=1:T
    %Alpha
    A = TrainWeak(i,2);
    %H(x)
    if(WeakData( TrainWeak(i,1) , 2 ) >  inData( WeakData( TrainWeak(i,1),1) , j  )) 
        %left
        H=WeakData( TrainWeak(i,1) , 3 );
    else
        %right
        H=WeakData( TrainWeak(i,1) , 3 ) * -1;
    end
    
    Sigma = Sigma + (A*H);
 
end
 
inDataResult(1,j) = sign(Sigma);
end
 
figure(2);
clf %clear current figure window
axis(plotstyle.range); hold on
axis('square')
title('Strong Classifier -> H(x)')
 
color={'c-','mo'};
 
for i=1:3:s
    plot( inData(1,i), inData(2,i), color{(inDataResult(1,i)+3)/2},'MarkerSize', 3 );
end
 
 
for i=1:Nsamples
    x = X(1,i);
    y = X(2,i);    
    plot(x, y, plotstyle.colors{(Y(i)+3)/2}, 'MarkerFaceColor', plotstyle.colors{(Y(i)+3)/2}(1), 'MarkerSize', 6);    
end
 
