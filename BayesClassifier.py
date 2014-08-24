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

def bayesClassifier(dat,mean,cov,prior):
    #discription paramter
    #dat : input vector(input data)
    #mean : mean of gaussian model
    #cov : covariance matrix of gaussian matrix
    #prior : prior probabilty
    [dim,num_data] = size(dat)
    num_classes = size(mean)
    dfce = zeros(num_classes,num_data)
    for i in range(i,num_classes):
        nconst =