function y = fde_ABM(Order,initialcond,RHS_fun,FinalTime,Nsteps)
% solve the fractional differential equation of the form: 
% D^\alpha_* y(t) = f(t,y(t))
% % using the ABM method described in Diethelm, 2004. 
% Input: 
%     Order: the fractional order
%     initialcond: the initial condition. For a single equation, it is a ROW vector of (y_0, y'_0,...). 
%         If the order <=1, it is only one scalar number. 
%     For a system of FDEs, this is a column vector (for order \le 1) and a matrix. 
%     RHS_fun: a function handle for the right hand side function f(t,y)
%     FinalTime: the final time. Here we solve for t in [0,FinalTime]. 
%     Nsteps: number of steps in time. The grid is uniform. 
% 
% OUTPUT: y is the solution at the grid points. 
%     For a single equation, it is a row vector. For a system, it is a matrix. 
%     Each column is the solution at a given time instant. 
% 
% Implemented by Thanh Nguyen, 2020. 

% ==========================

% Note: the initialcond variable can be a matrix. The number
% of rows is the size of the system, the number of column is the integer
% order of the FDE (the number of derivatives needed).


[Nvar,Norder] = size(initialcond); % number of variables, for a system. 

OrderN = floor(Order); %the largest integer no larger than the order

if Norder-1 ~= OrderN
    error('Order and input initial condition are not consistent'); 
end


dt = FinalTime/Nsteps; % step size in time. 
t = linspace(0,FinalTime,Nsteps); 

y = zeros(Nvar,Nsteps); % for the solution

y(:,1) = initialcond(:,1); 

f = @(t,u)RHS_fun(t,u); % the right hand side function

Gamma = gamma(Order); % gamma function value at Order

RHS = []; % calculate the righ hand side vector-valued function at t= 0.

% the loop: 
for k = 0:Nsteps-2
    
    ak = coef_a(k); % this calculates the vector of a_jk+1, j = 0,...,k+1
    bk = coef_b(k);
    
    InitialTerm = initial_cond_term(initialcond,t(k+2)); % the term containing the initial conditions. This term is shared between y^P_{k+1} and y_{k+1}. 
    RHS = rhs_vector(RHS,y(:,k+1),t(k+1)); % append the term f(t_{k+1}, y(t_{k+1}) to the vector RHS
    
    yP = InitialTerm + (RHS*bk)/Gamma; % predictor
    
    rhsP = f(t(k+2),yP); 
    
    y(:,k+2) = InitialTerm + (RHS*ak(1:k+1) + rhsP*ak(k+2))/Gamma; % corrector
    
end
% END OF MAIN FUNCTION. 


    % subfunctions: 
    function ak = coef_a(k)
        ak = zeros(k+2,1);
        ak(1) = k^(Order+1) - (k - Order)*(k+1)^Order;
        j = (1:k)'; 
        ak(j+1) = (k-j+2).^(Order+1) + (k-j).^(Order+1) - 2*(k-j+1).^(Order+1);
        ak(k+2) = 1; 
        ak = ak*dt^Order/Order/(Order+1);
        
    end

    function bk = coef_b(k)
        j = (0:k)'; % b is a column vector
        bk = dt^Order/Order*((k+1-j).^Order - (k-j).^Order);
        
    end

    function y = initial_cond_term(initcond,t)
        % note: initialcond is a matrix (# columns = # derivatives)
        j = (0:OrderN)'; 
        v = (t.^j)./factorial(j); 
        y = initcond*v; % use inner product instead of sum
        
    end

    function RHSnew = rhs_vector(RHS,yj,tj)
        % append the term f(t_{k+1}, y(t_{k+1}) to the vector RHS. Store
        % the whole vector to save calculation.
        
        RHSnew = [RHS, f(tj,yj)];
        
    end

end
