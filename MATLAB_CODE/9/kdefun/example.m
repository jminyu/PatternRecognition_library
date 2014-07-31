clc
echo on
% An example of the histogram, KDE, and bKDE using a normal distribution
%-----------------------------------------------------------------------------------
%
% produce a sample of 10000 points from a normal distribution

x=rand+randn(1,10000);

% calculate and plot the histogram

histo(x,0.4,0,'g--'); hold on

% calculate and plot KDE using the triangle kernel
 
kde(x,0.4,'ker1','b');

% bin the data into 100 bins

[xb,cb]=binden(100,x);

% calculate and plot BKDE using the triangle kernel

bkde(xb,cb,0.4,'ker1','r--'); hold off

% Hint: the difference between KDE and bKDE can be increased
% by reducing the number of bins used (in 'binden' function)
echo off
