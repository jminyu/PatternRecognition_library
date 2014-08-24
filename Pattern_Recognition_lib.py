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


class PR_Function:

    def Variation(self, data,mean):
        self.data = np.matrix(data)
        self.mean = mean
        return np.mean(np.inner(self.data,self.data))  - (pow(mean,2)) #variation

    def Gaussian_pdf(self,value,mean,standard_deriv):
        temp = (1/sqrt(2*math.pi))*(math.exp(-pow(value-mean,2)/(2*pow(standard_deriv,2))));
        return temp


    def Gaussian_dataset(self,data):
        # gaussian probability density function(gaussian distriduction)
        # data  - processed data
        self.data = np.array(data) #AttributeError: 'float' object has no attribute 'shape'
        dim_R, dim_C = self.data.shape
        gaussian_value = np.zeros((dim_R*dim_C),dtype=float)
        self.mean = np.mean(self.data)
        print "\tmean - ", self.mean
        standard_devi  = sqrt(self.Variation(self.data,self.mean))
        print "\tvariance - ",pow(standard_devi,2)
        print "\tstandard deviation - ",standard_devi
        batch_num = 0
        for i in range(0,dim_R):
            for j in range(0,dim_C):
                gaussian_value[batch_num] = self.Gaussian_pdf(data[i,j],self.mean,standard_devi)
                batch_num += 1
        return gaussian_value

def gaussian_2d(Dat,Mean,Cov):
    return np.exp(-0.5*(((Dat[1,:]-Mean[1,:]) / Cov[1,:])**2 + ((Dat[2,:]-Mean[2,:]) / Cov[2,:])**2))

def plotgaus(mean, cov, dat):
    delta = 0.025
    x = np.arange(-3.0, 3.0, delta)
    y = np.arange(-2.0, 2.0, delta)
    X, Y = np.meshgrid(x, y)
    Z = gaussian_2d(dat,mean,cov)
    # difference of Gaussians
    plt.clf()
    CS = plt.contour(X, Y, Z)
    plt.clabel(CS, inline=1, fontsize=10)
    plt.title('Gaussian Contoure')


if __name__ == "__main__":
    op = PR_Function()
    test_temp2 = np.zeros((100,100),dtype=float)
    gausian_temp3 = np.zeros((100,100),dtype=float)

    count = -5000
    for i in range(0,100):
        for j in range(0,100):
            test_temp2[i,j] = count
            gausian_temp3[i,j] = op.Gaussian_pdf(test_temp2[i,j],50,100)
            count +=1

    test_temp2 = np.reshape(test_temp2,(100*100))
    gausian_temp3 = np.reshape(gausian_temp3,(100*100))
    plt.figure(1)
    plt.plot(test_temp2,gausian_temp3);
    plt.show()

