#implementation of probabilty function
#Maximum Likelihood function
#Gaussian Distridution
from scipy.weave.c_spec import num_to_c_types

__author__ = 'Schmidtz'

import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
from numpy import matlib
from numpy import *
from numpy.random import *
import pylab as p
import math
from scipy import stats, mgrid, c_, reshape, random, rot90, linalg
from Data_generation import *


def Linear_Classifier(data):
    print 'nothing '

def ML_Gaussian(data,cov_type): #cov_type : covariance type
    print 'nothing '

def shoot(dat):
    temp_mean = np.mean(dat)
    temp_cov = np.mean(dat)
    return temp_mean, temp_cov


if __name__ == "__main__":
    #load data......
    #.......
    #gaussian processing

    '''
    random.seed(12345)
    dat = genData(500)
    dat_mean = mean(dat)
    dat_sigma = cov(dat)



    p.figure(1)
    p.plot(dat[0,:],dat[1,:],'b.')
    p.axis([0.0, 1.0,0.0,1.0]);
    p.show()
    '''




