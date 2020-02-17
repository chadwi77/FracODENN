import math
import numpy as np
import mittag_leffler

#check here
def step(func, t, dt, y_array,gamma_val,alpha):
        #For Loop
        #assume m = 1, T0 = constant = y0
        sum_val = 0
        h = dt**alpha
        n = len(y_array) # n is the size of the array pulled in, changes over time
        for j in range(0,n-1):
            m = n-j-1
            sum_val = sum_val + (((((m+1)**alpha) - (m)**alpha))/(gamma_val))*func(t,y_array[j])
        return h*sum_val #Return h^alpha * summation


def integrate(func,Nt,y0):
        # Array to size of Nt;
        y_array = [] #holder
        y_array.append(y0) #add initial value to y_array
        alpha = .5   #alpha is the order of the ode
        gamma_val = math.gamma(alpha + 1)
        dt = 1. / float(Nt)
        print(y0)
        #ml_array = []
        #ml_array.append(mittag_leffler.ml(-0**.5, .5))
        f_array = []
        f_array.append(0)
        t_array = []
        t_array.append(0)
        #ship to n+1
        print("Test")
        for n in range(1,Nt):
            t0 = 0 + n * dt
            #print('t')
            #print(t0)
            t_array.append(t0)
            #print('ml')
            #print('f(t)')
            #print(mittag_leffler.ml(-t0**.5, .5))
            f_array.append((t0**2)-t0)
            #ml_array.append(mittag_leffler.ml(-t0**.5, .5))
            #print(mlv)
            #print('y')
            y1 = step(func, t0, dt, y_array , gamma_val , alpha)
            #yn = Tm-1 + h*(y1), m = 1, Tm-1 = T0 or y0
            y1 = y0 + y1
            #print(y1) 
            y_array.append(y1) #Add new value to array
            np.savetxt('data.csv', np.transpose([t_array, y_array, f_array]), delimiter=',')
            #np.savetxt('data.csv', np.transpose([t_array, y_array, ml_array]), delimiter=',')
        return y1


    