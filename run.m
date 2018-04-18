%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: run_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

global A M T1 T2 T1_d T2_d q last_del

T1 = 1;
T2 = 1;
T1_d = 0.1;
T2_d = 0.2;
A = 1;    
M = 1;
q = 0;
last_del = 0;

%M = [1 1];

% plant initial conditions
% z1_0 = rand(1)*10;
% z2_0 = rand(1)*10;
z0 = 1;

% plant estimate initial conditions
zhat0 = 0;

y0 = M*z0;
y_m0 = y0;

% tau initial condition
tauP0 = 0;
tauO0 = 0;
tauN0 = 0;
taud0 = 0;

tP_m0 = 0;


% packet received flag
q0 = 0;

m0 = 0;

% state initial condition
x0 = [z0; zhat0; tauP0; tauO0; tauN0; taud0; q0; y0; y_m0; tP_m0; m0;];

% simulation horizon
TSPAN=[0 20];
JSPAN = [0 90];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.01);

% simulate
[t,j,x] = HyEQsolver( @f,@g,@C,@D,...
    x0,TSPAN,JSPAN,rule,options,'ode45');

% plot solution
figure(1) % position
clf
subplot(2,1,1), plotHarc(t,j,x(:,1));
grid on
ylabel('$z$','Interpreter','latex','FontSize',20)
subplot(2,1,2), plotHarc(t,j,x(:,2));
grid on
ylabel('$\hat{z}$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

% plot solution
figure(2) % position
clf
subplot(2,1,1), plotHarc(t,j,x(:,1) - x(:,2));
grid on
ylabel('$e$','Interpreter','latex','FontSize',20)
subplot(2,1,2), plotHarc(t,j,x(:,7));
grid on
ylabel('$q$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

figure(3) % position
clf
subplot(2,1,1), plotHarc(t,j,x(:,3));
grid on
ylabel('$\tau_P$','Interpreter','latex','FontSize',20)
subplot(2,1,2), plotHarc(t,j,x(:,4));
grid on
ylabel('$\tau_O$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

figure(4) % position
clf
subplot(2,1,1), plotHarc(t,j,x(:,5));
grid on
ylabel('$\tau_N$','Interpreter','latex','FontSize',20)
subplot(2,1,2), plotHarc(t,j,x(:,6));
grid on
ylabel('$\tau_{\delta}$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

figure(5) % position
clf
subplot(2,1,1), plotHarc(t,j,x(:,8));
grid on
ylabel('$y$','Interpreter','latex','FontSize',20)
subplot(2,1,2), plotHarc(t,j,x(:,9));
grid on
ylabel('$y_{meas}$','Interpreter','latex','FontSize',20)
xlabel('$t$','Interpreter','latex','FontSize',20)

figure(6)
plot(t,x(:,6),t,x(:,8),t,x(:,11));

figure(7) % position
clf
plotHarc(t,j,x(:,1) - x(:,2));
grid on
ylabel('$|\varepsilon|$','Interpreter','latex','FontSize',50)
xlabel('$t,j$','Interpreter','latex','FontSize',50)

% % plot phase plane
% figure(3) % position
% clf
% plotHarcColor(x(:,1),j,x(:,2),t);
% xlabel('x_1')
% ylabel('x_2')
% grid on

% plot hybrid arc
% figure(3)
% plotHybridArc(t,j,x)
% xlabel('j')
% ylabel('t')
% zlabel('x1')
% grid on
% 
% mgh = x(:,1)*9.8;
% mv = 0.5*(x(:,2)).^2;
% 
% totJ = mgh + mv;
% 
% figure(4) % energy
% clf
% subplot(2,1,1), plotHarc(t,j,mgh);
% grid on
% ylabel('potential energy')
% subplot(2,1,2), plotHarc(t,j,mv);
% grid on
% ylabel('kinetic energy')
% 
% figure(5)
% clf
% plotHarc(t,j,totJ)
% grid on
