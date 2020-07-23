% HoChiMinh University of Technology
% 
% Filename     : PFmain.m
% Description  : particle filter
% 
% 
% Author       : tai.nguyen1011@hcmut.edu.vn
% Created On   : 22/05/2020
% History (Date, Changed By)
clear all;
param;
%CREATE PARTICLE FILTER
X = zeros(2, para.timedomain);    
Z = zeros(2, para.timedomain);

P_init = zeros(2, para.N);    
P = zeros(2, para.N);         
  
w = zeros(para.N, 1);         

%INITIAL STATE
X(:, 1) = [80; 40];    

%INITIAL OBSERVATION
Z(:, 1) = X(:,1) + wgn(2,1,para.snr);    


for i = 1 : para.N
    P_init(:, i) = [para.framex*rand; para.framey*rand];
end
     

P = P_init;
figure(1);
plot(P(1, :), P(2, :), 'b.', 'markersize',10);   % Particle position
for k = 2 : para.timedomain
    %INPUT Ut
    route1 = para.step*[cos(k * para.angle); sin(k * para.angle)];
    %PROCESS MODEL
    X(:, k) = X(:, k-1) + route1  + wgn(2,1,para.snr);
    %LANDMARK
    Z(:, k) = X(:, k) + wgn(2,1,para.snr);
    
    %MEASUREMENT MODEL
    for i = 1 : para.N
        %SAMPLE PARTICLE p(xt|ut,xt-1)
        P(:, i) = P(:, i) + route1 + wgn(2,1,para.snr);
        
        %EUCLIDEAN DISTANCE TO LANDMARK p(zt|xt)
        d = norm(P(:, i)-Z(:, k));
        
        %LIKELIHOOD
        w(i) = (1/sqrt(para.noise*2*pi))*exp(-d^2/(2*para.noise));  
    end
    %NORMALIZE IMPORTANCE WEIGHT    
    wsum = sum(w);
    for i = 1 : para.N
        wnorm(i) = w(i) / wsum;
    end
    
    %RESAMPLING
    for i = 1 : para.N
    	%Roulette Wheel
        wmax = 2 * max(wnorm) * rand;
        index = randi(para.N, 1);
        while(wmax > wnorm(index))
            wmax = wmax - wnorm(index);
            index = index + 1;
            if index > para.N
                index = 1;
            end          
        end
        %UPDATE PARTICLE
        P(:, i) = P(:, index);  
        
    end
    figure(2);
    clf;
    hold on
    plot(X(1, k), X(2, k), 'm.', 'markersize',50);  % System status
    axis([-50 150 -10 100]);
    plot(P(1, :), P(2, :), 'b.', 'markersize',10);   % Particle position   
    grid;
    hold off
    pause(0.5);
end

