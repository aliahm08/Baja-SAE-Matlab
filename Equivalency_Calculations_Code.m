% # Baja-SAE-Matlab
% Unit Conversions and Testing to ensure standards are met for SAE Baja off-road vehicle.

%% Intro
% Title: Equivalency Calculations
% Baja SAE - George Washington University
% 2015-2016
% Programmers: Ali Ahmed, Jacari Matthews
% Leader: Tyler Miller
%% Initatiation
clc;
clear all;

%% Tube Specifications and Conversions
% Primary Tube
    OD1 = convlength(1.25, 'in', 'm'); 
    ID1 = convlength(1.12, 'in', 'm');
% Secondary Tube
    OD2 = convlength(1.00, 'in', 'm');
    ID2 = convlength(0.87, 'in', 'm');
% modulus of Elasticity
    E = 205.;
% yield strength
    Sy = (convpres(109000, 'psi', 'Pa'))*(10.^(-6));
% radius
    c1 = (OD1/2.)*(10.^3); c2 = (OD2/2.)*(10.^3);

%% Calculations
%%Moments of Intertia
    I1 = (pi * ((OD1*10.^3.)^4. - (ID1*10.^3.)^4.)) / 64.;
    %   OUTPUT = 1.7732e+04 mm
    I2 = (pi * ((OD2*10.^3.)^4. - (ID2*10.^3.)^4.)) / 64.;
    %   OUTPUT = 8.7264e+03 mm
    
%%Bending Stiffness
    B1 = E * I1;
    %   OUTPUT = 3.6351e+6
    B2 = E * I2;
    %   OUTPUT = 1.7889e+6

%%Bending Strength
    BS1 = (Sy * I1)/c1;
    %   OUTPUT = 8.3946e+5 N-mm
    BS2 = (Sy * I2)/c2;
    %   OUTPUT = 5.1639e+5 N-mm
