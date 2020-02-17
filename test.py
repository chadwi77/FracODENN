import math
import numpy as np
import odesolverNN
import mittag_leffler

#def func(t,y):
#    return -1*y

def func(t,y):
    a = .5
    pt1 = ((2/math.gamma(3-a))*(t**(2-a))) - ((1/math.gamma(2-a))*(t**(1-a)))
    pt2 = -1*(y)+(t**2)-t
    return pt1 + pt2


u = odesolverNN.integrate(func,320,0)
#mlv = mittag_leffler.ml(-1**.5, .5)
#print(u)
#print(mlv)


