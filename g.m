function xplus = g(x)
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: g_ex1_2.m
%--------------------------------------------------------------------------
% Project: Simulation of a hybrid system (bouncing ball)
% Description: Jump map
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

    % state
    %x0 = [z0; zhat0; tauP0; tauO0; tauN0; taud0; q0; y0; y_m0;];
    z = x(1);
    zhat = x(2);
    tauP = x(3);
    tauO = x(4);
    tauN = x(5);
    taud = x(6);
    q    = x(7);
    y    = x(8);
    y_m  = x(9);
    tP_m = x(10);
    m = x(11);

    global A T1 T2 T1_d T2_d M L
    
    if (tauP > 8)
        display(tauP);
    end
    
    G = (1 - q) + 2*q;
    
    if ((tauN <= 0) && (G == 1)) 
        zhat_plus = zhat;
        taud_plus = T1_d+(T2_d-T1_d).*rand(1,1);
        tauN_plus = T1+(T2-T1).*rand(1,1);
        y_m       = y;
        tP_m      = tauP;
        q         = 1;
        mplus = m;
    elseif ((taud <= 0) && (G == 2))
        
        del = tauO - tP_m;
        
        zhat_del  = expm(-A*del)*zhat;
        zhat_rev  = zhat_del + L*(y_m - M*zhat_del);
        zhat_plus = expm(A*del)*zhat_rev;
        mplus = expm(A*del)*y_m;
        taud_plus = 2*T2_d + 1;
        tauN_plus = tauN;
        
        q = 0;
    else
        taud_plus = taud;
    end
        
    
    
    xplus = [z; zhat_plus; tauP; tauO; tauN_plus; taud_plus; q; y; y_m; tP_m; mplus];
    
end