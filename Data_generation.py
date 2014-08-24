__author__ = 'Schmidtz'

import matplotlib
import numpy as np
import matplotlib.cm as cm
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt

import matplotlib as mpl
import numpy as np
from numpy import matlib
from numpy import *
from numpy.random import *
import pylab as p
import math
from scipy import stats, mgrid, c_, reshape, random, rot90, linalg

from Prob_function import *

def genData(Ndat):
        c1 = 0.5
        r1 = 0.4
        r2 = 0.3
        # generate enough data to filter
        N = 20*Ndat
        X = array(random_sample(N))
        Y = array(random_sample(N))
        X1 = X[(X-c1)*(X-c1) + (Y-c1)*(Y-c1) < r1*r1]
        Y1 = Y[(X-c1)*(X-c1) + (Y-c1)*(Y-c1) < r1*r1]
        X2 = X1[(X1-c1)*(X1-c1) + (Y1-c1)*(Y1-c1) > r2*r2]
        Y2 = Y1[(X1-c1)*(X1-c1) + (Y1-c1)*(Y1-c1) > r2*r2]
        X3 = X2[ abs(X2-Y2)>0.05 ]
        Y3 = Y2[ abs(X2-Y2)>0.05 ]
        #X3 = X2[ X2-Y2>0.15 ]
        #Y3 = Y2[ X2-Y2>0.15]
        X4=zeros(Ndat, dtype=float32)
        Y4=zeros(Ndat, dtype=float32)
        for i in xrange(Ndat):
            if (X3[i]-Y3[i]) >0.05:
                X4[i] = X3[i] + 0.08
                Y4[i] = Y3[i] + 0.18
            else:
                X4[i] = X3[i] - 0.08
                Y4[i] = Y3[i] - 0.18
        print "X", size(X3[0:Ndat]), "Y", size(Y3)
        return(vstack((X4[0:Ndat],Y4[0:Ndat])))


if __name__ == "__main__":
    random.seed(12345)
    dat = genData(500)

    print dat.shape

    plt.figure(1)
    plt.plot(dat[0,:],dat[1,:],'b.')


    sigma_x, mu_x = shoot(dat[0,:])
    sigma_y, mu_y = shoot(dat[1,:])


    matplotlib.rcParams['xtick.direction'] = 'out'
    matplotlib.rcParams['ytick.direction'] = 'out'

    delta = 0.025
    X, Y = np.meshgrid(dat[0,:],dat[1,:])
    G = mlab.bivariate_normal(X, Y, sigma_x, sigma_y, mu_x, mu_y)



    # Create a simple contour plot with labels using default colors.  The
    # inline argument to clabel will control whether the labels are draw
    # over the line segments of the contour, removing the lines beneath
    # the label
    CS = plt.contour(X, Y, G)
    plt.title('Simplest default with labels')
    plt.show()
