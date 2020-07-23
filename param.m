% HoChiMinh University of Technology
% 
% Filename     : param.m
% Description  : parametter particle filter
% 
% 
% Author       : tai.nguyen1011@hcmut.edu.vn
% Created On   : 22/05/2020
% History (Date, Changed By)

%Number particle
para.N=500;

%Noise rate
para.noise=20;
para.snr=10*log10(para.noise);

%Time domain simulate
para.timedomain=10;

%Steering angle
para.angle=pi/4;

%Distance moving
para.step=20;

%Frame size
para.framex=300;
para.framey=50;




