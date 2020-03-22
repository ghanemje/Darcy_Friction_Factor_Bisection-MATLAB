%% Numerical Methods Mini Project 1: Darcy Friction Factor
%% by Ghanem Jamaleddine 58261
clc
clear
close all

% Define 20 numbers from 0 to 0.05 for e/d and 4000 to 10^8 for Re
ed=[0 0.001 0.002 0.005 0.01 0.02 0.05 0.1 0.2 0.5 1 2 5 10 15 20 30 35 40 50]*10^-3;
Re= [4 5 10 20 40 80 100 150 300 500 700 1000 3000 5000 8000 10000 30000 50000 80000 100000]*10^3;

% Start i counter from 1 to length of ed (20)
for i=1:length(ed)
    % Start j counter from 1 to length of Re (20)
    for j=1:length(Re)
        % Set error critera (Ec) and define approximate error (Eap)
        Ec=0.000001;
        Eap=inf;
        % Define x lower and x upper
        xL=0.001;
        xu=1;
        % Start while loop for bisection and repeat if Eap greater than Ec
        while(Eap > Ec)
            % Define xr
            xr(i,j)=(xL+xu)/2;
            gxr= 1 + 2* sqrt(xr(i,j))*log10(ed(i)/3.7 + 2.51/(Re(j)*sqrt(xr(i,j))));
            gxu= 1 + 2* sqrt(xu)*log10(ed(i)/3.7 + 2.51/(Re(j)*sqrt(xu)));
            % If statement to set new values for x upper or x lower based
            % on results of gxu or times xr
            if gxu*gxr>0
                xu=xr(i,j);
            else
                xL=xr(i,j);
            end
            % Define new value for Eap
            Eap=abs(xu-xL);
        end
    end
    % Plot f vs Re
    grid on
    hold on
    yyaxis left
    plot(Re,xr(i,1:length(xr)),'-')
    set(gca, 'XScale','log')
    title ("Moody Diagram by Ghanem Jamaleddine")
    xlabel("Reynold's Number, Re");
    ylabel("Friction Factor, f")
    % Set secondary y axis from ed
    yyaxis right
    ylim([0 0.05])
    ylabel("Relative Roughness, e/D")
end
              