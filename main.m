% Algoritmo: Modelo de Boids descrito por Reynolds (com adição de
% obstáculos)
% Disciplina: Inteligência Computacional
% Professor: Dr. Paulo Henrique da Fonseca Silva
% Alunos: 
%   Marcelo Sousa Gomes
%   Rafael Duarte de Sousa
%
% ====================================================================
clc; clear all; close all;
help main;

%% Randomness
% rng for reproducibility (comente se for usar no octave)
rng(2);

%% Universe parameters
universeLimits = [0 100];
numIterations = 500;

%% Boids parameters
totalBoids = 50;
boidSize = 0.25.*[2.5 1.5]; %Used in the plots
boidVelocity = 1;

% Standard Deviance of random direction changes (based on Couzin)
stdDev_dir = 0.1;

radiusZones = [2 10 15]; %Rs, Ra, Rc
% Rs = Max Radius Separation Zone
% Ra = Max Radius Alignment Zone
% Rc = Max Radius Cohesion Zone

forceParam = [1 1 1]; %S, M, K
% S = Collision avoidance --> Separation (other boids)
% M = Velocity Matching --> Alignment (other boids)
% K = Flock Centering --> Cohesion (other boids)

%% Obstacle parameters
obstacle = struct('position', {});
numObstacles = 15;

% Size of the obstacle
obstSize = 5;

% Minimal distance between a boid and an obstacle
obstRadius = obstSize*sqrt(2)+2;

%% Boids creation/Initial State
for i = 1:totalBoids
    
    % Uniform distribution
    boidPosition = universeLimits(1) + floor(rand(1, 2).* ...
       (universeLimits(2) - universeLimits(1)));
    
    %Normal distribution:
        %: mean = universeLimits(2)/2
        %: stdev = universeLimits(2)/2 .* 0.25
    %boidPosition = (universeLimits(2)/2)*(1 + randn(1,2).*0.25);
    
    boid_temp_dir = rand(1, 2);
    boidDirection = boid_temp_dir/norm(boid_temp_dir);
    
    boid(i) = Boid(boidPosition, boidDirection, boidVelocity);
end


%% Obstacle Creations/Initial State
i=1;
while i<= numObstacles
    if i==1
        obstacle(i).position = (universeLimits(1) + 0.5*obstSize) + ...
            floor(rand(1, 2).*((universeLimits(2) - 0.5*obstSize) - ...
            (universeLimits(1) + 0.5*obstSize)));
    else
        obstacle(i).position = (universeLimits(1)+ 0.5*obstSize) + ...
            floor(rand(1, 2).*((universeLimits(2)- 0.5*obstSize) - ...
            (universeLimits(1) + 0.5*obstSize)));
        for j = 1:i
            distanceObst(j) = norm(obstacle(i).position - ...
                obstacle(j).position);
        end
        if(~isempty(find(distanceObst>0 & distanceObst<=obstRadius)))
          continue;
        end
    end
    i = i + 1;
end

%% Plotting the initial state
% Prompts the user to press a key in order to show further iterations
plot_state(boid, obstacle, universeLimits, boidSize, obstSize, ...
    '0 - Pressione uma tecla no console para continuar');
input('Pressione uma tecla para continuar');

%% Boids and plot update
for it = 1:numIterations
    boid = boid_update(boid, obstacle, obstRadius,radiusZones,forceParam,...
        universeLimits, stdDev_dir);
    plot_state(boid, obstacle, universeLimits, boidSize,obstSize,it);
end

