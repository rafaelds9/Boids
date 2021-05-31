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
numIterations = 4*50;

% Para ter repetibilidade (comente se for usar no octave)
rng(2);

%% Parâmetros dos boids
totalBoids = 75;

% Ao adicionar a aceleração posso botar um range mais amplo
initVelocityRange = [2 5];

% Distâncias para cada regra
dis_repulsion = 120;
dis_alignment = 180;
dis_atraction = 220;


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

%% Atualização dos boids do plot (mexer na aceleração, angulo de visão)
for it = 1:numIterations
    boid = boid_update(boid, dis_repulsion, dis_alignment,dis_atraction,...
        universeLimits);
    plot_state(boid, universeLimits,it);
end

