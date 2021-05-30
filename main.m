clc; clear all; close all;
%% Description
% Algoritmo Boids
% Disciplina: Inteligência Computacional
% Professor: Dr. Paulo Henrique da Fonseca Silva
% Alunos: 
%   Marcelo 
%   Rafael Duarte de Sousa


%% Parâmetros do universo
universeLimits = [0 500];

%% Parâmetros dos boids
totalBoids = 75;
initVelocityRange = [0 4];
% size of the drawing of the boids (based on the universeSize)
% Originally:
boidSize = [2.5 1.5];

% According to the universe size
%boidSize = (max(universeLimits)-min(universeLimits)).*[0.005 0.003];

%%

ss = get(0, 'ScreenSize');
Fig1=figure(1);
set(Fig1,'Position',[ss(1) ss(2) ss(3) ss(4)],'Color',[1 1 1], ...
    'NextPlot','Replace');

%% Criação dos boids/Estado inicial dos boids
hold on;
for i = 1:totalBoids
    boidPosition = universeLimits(1) + floor(rand(1, 2).* ...
        (universeLimits(2) - universeLimits(1)));
    
    boid_temp_dir = rand(1, 2);
    boidDirection = boid_temp_dir/norm(boid_temp_dir);
    
    boidVelocity = initVelocityRange(1)+rand(1)* ...
        (initVelocityRange(2)-initVelocityRange(1));
    
    boid(i) = Boid(boidPosition, boidDirection, boidVelocity);
    
    pos = boidPosition;
    
    x = [boidPosition(1)-boidSize(1) boidPosition(1)+boidSize(1) ...
        boidPosition(1)-boidSize(1) boidPosition(1)-boidSize(1)];
    y = [boidPosition(2)-boidSize(2) boidPosition(2) boidPosition(2)+ ...
        boidSize(2) boidPosition(2)+boidSize(2)];
    
    boid_drawing(i) = patch(x,y,'k');
    %% Ver onde está a rotação
    angle_rotation_deg = atand(boidDirection(2)/boidDirection(1));
    rotate(boid_drawing(i),[0 0 1], angle_rotation_deg, [boidPosition(1) boidPosition(2) 0]);
    
end
hold off;
title('Boids - Iteração inicial')
xlim(universeLimits);
ylim(universeLimits);

%% Adicionar movimento à eles


