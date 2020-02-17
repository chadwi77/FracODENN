import math
import numpy as np
import mittag_leffler

#check here
def step(func, t_array, dt, y_array,gamma_val,alpha):
        #For Loop
        h = dt
        sum_val = 0
        
        for j in range (0,k):
            a(j,k+1)*func(t[j],y_array[j])

        
        #Splitting sections by parts
        #part1 b_(j,k+1)
        #Part 2 (yp_(k+1))
        #yp = 1 + 

        
        return (1/gamma_val)*sum_val 


def integrate(func,Nt,y0):
        # Array to size of Nt;
        y_array = [] #holder
        y_array.append(y0) #add initial value to y_array
        alpha = .5   #alpha is the order of the ode
        g_val = math.gamma(alpha)
        dt = 1. / float(Nt)
        #f_array = []
        #f_array.append(0)
        t_array = []
        t_array.append(0)
        #ship to n+1
        print("Test")
        for t in range(1,Nt):
            t0 = 0 + t * dt
            t_array.append(t0)


        for n in range(1,Nt):
            #t0 = 0 + n * dt
            #Prepopulate T array for later use            
            y1 = step(func, t_array, dt, y_array,g_val,alpha)
            #In our case, the ceiling of alpha will always be 1
            #if we bound it between 0<=alpha<1
            y1 = y0 + y1
            y_array.append(y1) #Add new value to array
        return y1


    