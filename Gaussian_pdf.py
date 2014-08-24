#__Author = 'Jongmin Yu' @ Ph.D Candidate @ GIST-MLV
#__Laboratory of Machine Learning and Computer Vision
#
#--Title.Gaussian probability density function for image file
#__data format  = numpy
#
from math import sqrt
from parser import st2list
import matplotlib

__author__ = 'Schmitz'


from matplotlib import pyplot as plt
import numpy as np
from scipy import *
import math
from numpy import *
from numpy import matlib,linalg
import random
import cv2
from scipy import *

import matplotlib
import numpy as np
import matplotlib.cm as cm
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import pylab as p

from Prob_function import shoot
from Data_generation import genData



def gaussian_value(dat,mu,co):
        dim,num_dat = dat.shape
        temp_gaus = np.zeros((num_dat),dtype=float)
        for i in range(0,num_dat):
            temp_gaus[i] = Gaussian_2d(dat[0,i],dat[1,i],mu[0],mu[1],co[0],co[1])
        print temp_gaus.shape
        return temp_gaus

def Gaussian_pdf(value,mean,standard_deriv):
        temp = (1/sqrt(2*math.pi))*(math.exp(-pow(value-mean,2)/(2*pow(standard_deriv,2))));
        return temp

def Gaussian_2d(x, y, x0, y0, xsig, ysig):
    return np.exp(-0.5*(((x-x0) / xsig)**2 + ((y-y0) / ysig)**2))

if __name__ == "__main__":
    #loading data
    random.seed(12345)
    dat = genData(500)
    mu = np.zeros((2,1),dtype=float)
    co = np.zeros((2,1),dtype=float)
    #print dat.shape






    mu[0], co[0] = shoot(dat[0,:])
    mu[1], co[1] = shoot(dat[1,:])

    gaussian_data = gaussian_value(dat,mu,co)

    p.clf()
    p.plot(dat[0,:],dat[1,:],'b.')
    p.plot(mu[0],mu[1],'r.')
    p.axis([0.0, 1.0,0.0,1.0])

    print dat[0,:].shape
    print dat[1,:].shape
    print gaussian_data.shape

    CS = p.contour(dat[0,:],dat[1,:],gaussian_data)
    p.clabel(CS,inline=1,fontsize=10)
    p.title('Gaussian distribution')
    p.show()

