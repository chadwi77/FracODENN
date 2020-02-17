% test the function "fde_ABM" for solving fractional differential equation

Nsteps = 321; FinalTime = 1; 
t = linspace(0,FinalTime,Nsteps); 

% Example 1: 
Order = 3/2; % Order must be > 1. 
ExactSol = t.^2 - t; 
RHS_fun = @(t,y)(2/gamma(3-Order)*t^(2-Order) - y + t^2 - t); 
initialcond = [0, -1]; 


% % Example 2: 
% Order = 1/2; 
% ExactSol = t.^2 - t; 
% RHS_fun = @(t,y)(2/gamma(3-Order)*t^(2-Order) - 1/gamma(2-Order)*t^(1-Order) - y + t^2 - t); 
% initialcond = 0; 
% 

% % Example 3: 
% Order = 1/2; 
% ExactSol = t.^8 - 3*t.^(4 + Order/2) + 9/4*t.^Order; 
% RHS_fun = @(t,y)(  40320/gamma(9-Order)*t^(8-Order) ...
%                  - 3*gamma(5+Order/2)/gamma(5-Order/2)*t^(4-Order/2) ...
%                  + 9/4*gamma(Order+1) ...
%                  + (3/2*t^(Order/2) - t^4)^3 ...
%                  - y^(3/2) ); 
% initialcond = 0; 


% % Example 4: 
% Order = 1/2;
% ExactSol = mittag_leffler(-t.^Order,Order,1); 
% RHS_fun = @(t,y)(-y); 
% initialcond = 1; 




% ============== Call the solver: 

NumSol = fde_ABM(Order,initialcond,RHS_fun,FinalTime,Nsteps); 


% ============== plot results: 
figure(1); 
subplot(2,1,1);
plot(t,ExactSol,'linewidth',2); 
hold on; plot(t,NumSol,'--r','linewidth',2); hold off;

legend('exact solution','the ABM method'); 

fprintf('%s%3.2f%s%6.5f\n','Error at t = ', t(end),' is: ',NumSol(end) - ExactSol(end));

subplot(2,1,2); 
plot(t,NumSol - ExactSol,'linewidth',2); title('Error'); 
legend('Numerical solution - Exact solution'); 

