% Algoritmo: Modelo de Boids descrito por Reynolds
% Disciplina: Inteligência Computacional
% Professor: Dr. Paulo Henrique da Fonseca Silva
% Alunos: 
%   Marcelo Sousa Gomes
%   Rafael Duarte de Sousa

clc; clear all; close all;
help main;

%% Parâmetros do universo
universeLimits = [0 300];
numIterations = 5000;

%% Aleatoriedades 
% rng abaixo para ter repetibilidade (comente se for usar no octave)
rng(2);

%% Parâmetros dos boids
totalBoids = 20;

boidSize = [2.5 1.5]; %Used in the plots

boidVelocity = 1;

% Standard Deviance of random direction changes (based on Couzin)
stdDev_dir = 0.05;

radiusZones = [8 9 10]; %Rs, Ra, Rc
% Rs = Max Radius Separation Zone
% Ra = Max Radius Alignment Zone
% Rc = Max Radius Cohesion Zone

forceParam = [1 1 1]; %S, M, K
% S = Collision avoidance --> Separation (other boids)
% M = Velocity Matching --> Alignment (other boids)
% K = Flock Centering --> Cohesion (other boids)

%% Parâmetros dos obstáculos



%% Criação dos boids/Estado inicial dos boids
for i = 1:totalBoids
    
    % Uniform distribution
    boidPosition = universeLimits(1) + floor(rand(1, 2).* ...
       (universeLimits(2) - universeLimits(1)));
    
    %Normal distribution:
        %: mean = universeLimits(2)/2
        %: stdev = universeLimits(2)/2 .* 0.5
    %boidPosition = (universeLimits(2)/2)*(1 + randn(1,2).*0.5);
    
    boid_temp_dir = rand(1, 2);
    boidDirection = boid_temp_dir/norm(boid_temp_dir);
    
    boid(i) = Boid(boidPosition, boidDirection, boidVelocity);
end

%% Plotagem do estado inicial
plot_state(boid, universeLimits, boidSize, ...
    '0 - Pressione uma tecla no console');
input('Pressione uma tecla para continuar');

%% Atualização dos boids do plot (mexer na aceleração, angulo de visão)
for it = 1:numIterations
    boid = boid_update(boid, radiusZones, forceParam,...
        universeLimits, stdDev_dir);
    plot_state(boid, universeLimits, boidSize,it);
end

