function [boid] = boid_update(boid, dis_repulsion, dis_alignment, ...
    dis_atraction, universeLimits)
%BOID_UPDATE Calculates each force involved in the flock's behaviour and
% sums them in order to find the
%   Detailed explanation goes here

    % Priorities to each behaviour
    S = 1; % Collision avoidance (other boids)
    K = 0.5; % Velocity Matching (other boids)
    M = 0.5; % Flock Centering (other boids)
    
    % Colocar uma variação da velocidade e não da posição (fica mais
    % fluido)

    % CALCULANDO A NOVA POSIÇÃO E DIREÇÃO PARA CADA BOID
    for i = 1 : length(boid)
        %% CALCULANDO A DISTÂNCIA ENTRE OS BOIDS (i E DEMAIS)
        distance = zeros(length(boid), 1);
        for j = 1 : length(boid)
            distance(j) = norm(boid(i).position - boid(j).position);
        end
        
        %% SEPARATION BEHAVIOUR
        % Identifica todos os boids dentro da distancia de repulsao
        repulsion_id = find(distance<=dis_repulsion);
        %quantifica os que devem ser repelidos
        num_rep = length(repulsion_id);
        %zera o vetor separação (variação da posição) (pois vai iterar)
        separacao = [0 0];
        if num_rep > 0
            %idem, pois vai iterar
            position = zeros(1, 2);
            for j = 1:num_rep
                % Soma todos os vetores de repulsão
                position = position + boid(repulsion_id(j)).position;
            end
            position = round(position ./ num_rep);
            separacao = boid(i).position - position;  
        end

        %% ALIGNMENT BEHAVIOUR
        alignment_id = find(distance<=dis_alignment);
        num_agm = length(alignment_id);
        temp_direction = 0;
        alinhamento = [0 0];
        if num_agm > 0
            boid(i).direction = zeros(1, 2);
            for j = 1 : num_agm
                temp_direction = temp_direction + boid(alignment_id(j)).direction;
            end
           alinhamento = boid(i).direction + temp_direction/norm(temp_direction);
        end

        %% COHESION BEHAVIOUR
        attraction_id = find(distance<=dis_atraction);
        num_att = length(attraction_id);
        coesao = [0 0];
        if num_att > 0
            position = zeros(1, 2);
            for j = 1 : num_att
                position = position + boid(attraction_id(j)).position;
            end
            position = round(position ./ num_att);
            boid(i).direction =  boid(i).direction + position - boid(i).position;
            coesao = boid(i).direction / norm(boid(i).direction);
        end
        
        %% Summing the forces
        %acceleration = 
        
        % Entender
        vet_direction = [10 5]; %VETOR DE DIREÇÃO
        
        %%
        % CALCULO DA DIREÇÃO RESULTANTE
        boid(i).direction = boid(i).direction + S*separacao + M*alinhamento + K*coesao + vet_direction;
        boid(i).direction = boid(i).direction / norm(boid(i).direction);
        
        % CALCULO DA POSIÇÃO RESULTANTE E ADICIONANDO MOVIMENTO 
        boid(i).position = round(boid(i).position + boid(i).direction .* boid(i).velocity);
        
        % DEFININDO A POSIÇÃO DE BOIDS DENTRO DA FAIXA
        boid(i).position = mod(boid(i).position + universeLimits(2), universeLimits(2)); 
    end

end

