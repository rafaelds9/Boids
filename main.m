% Algoritmo: Modelo de Boids descrito por Reynolds
% Disciplina: Inteligência Computacional
% Professor: Dr. Paulo Henrique da Fonseca Silva
% Alunos: 
%   Marcelo Sousa Gomes
%   Rafael Duarte de Sousa

clc; clear all; close all;

help main;

%% Parâmetros do universo
universeLimits = [0 500];
numIterations = 100;

%% Parâmetros dos boids
totalBoids = 75;
initVelocityRange = [0 4];

% Distâncias para cada regra



%% Criação dos boids/Estado inicial dos boids
for i = 1:totalBoids
    boidPosition = universeLimits(1) + floor(rand(1, 2).* ...
        (universeLimits(2) - universeLimits(1)));
    
    boid_temp_dir = rand(1, 2);
    boidDirection = boid_temp_dir/norm(boid_temp_dir);
    
    boidVelocity = initVelocityRange(1)+rand(1)* ...
        (initVelocityRange(2)-initVelocityRange(1));
    
    boid(i) = Boid(boidPosition, boidDirection, boidVelocity);
end

%% Plotagem do estado inicial
plot_state(boid, universeLimits,'0 - Pressione uma tecla no console');
input('Pressione uma tecla para continuar');

%% Adicionar movimento à eles (update contínuo, drawnow e pá dentro da função)
for it = 1:2
    plot_state(boid, universeLimits,it);
end

