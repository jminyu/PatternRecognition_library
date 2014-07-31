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
import scipy
import math
import random
import cv2


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

