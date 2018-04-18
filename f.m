function xdot = f(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: f_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Flow map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00
    
    % state
    z = x(1);
    zhat = x(2);
    q = x(7);

    global A M
    
    % differential equations
   
    if q == 1
        taudF = -1;
    else
        taudF = 0;
    end
    
    xdot = [A*z; A*zhat; 1; 1; -1; taudF; 0; M.*z; 0; 0;0;];
    
end