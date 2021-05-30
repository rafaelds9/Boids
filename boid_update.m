function [boid] = boid_update(boid, dis_repulsion, dis_alignment, ...
    dis_atraction,  universeLimits)
%BOID_UPDATE Summary of this function goes here
%   Detailed explanation goes here
    S = 0.5; K = 0.5; M = 0.5;

    % CALCULANDO A NOVA POSIÇÃO E DIREÇÃO PARA OS BOIDS
    for i = 1 : length(boid)
        %% CALCULANDO A DISTÂNCIA ENTRE OS BOIDS (ATUAL E OUTROS)
        distance = zeros(length(boid), 1);
        for j = 1 : length(boid)
            distance(j) = norm(boid(i).position - boid(j).position);
        end
        %% REGRA DE SEPARAÇÃO/REPULSÃO
        repulsion_id = find(distance>0 & distance<=dis_repulsion);
        num_rep = length(repulsion_id);
        separacao = [0 0];
        if num_rep ~= 0
            position = zeros(1, 2);
            for j = 1 : num_rep
                position = position + boid(repulsion_id(j)).position;
            end
            position = round(position ./ num_rep);
            separacao = boid(i).position - position;  
        end

        %% REGRA DE ALINHAMENTO
        alignment_id = find(distance>dis_repulsion & distance<=dis_alignment);
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

        %% REGRA DE ATRAÇÃO
        attraction_id = find(distance>dis_alignment & distance<=dis_atraction);
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
        else
           boid(i).position = round(boid(i).position + boid(i).direction .* boid(i).velocity + randn(1,2).*boid(i).velocity*0);
        end
        vet_direction = [10 5]; %VETOR DE DIREÇÃO

        % CALCULO DA DIREÇÃO RESULTANTE
        boid(i).direction = boid(i).direction + S*separacao + M*alinhamento + K*coesao + vet_direction;
        boid(i).direction = boid(i).direction / norm(boid(i).direction);
        % CALCULO DA POSIÇÃO RESULTANTE E ADICIONANDO MOVIMENTO 
        %boid(i).direction = (boid(i).direction + 0.1*quad);
        boid(i).position = round(boid(i).position + boid(i).direction .* boid(i).velocity + randn(1,2).*boid(i).velocity*0.1*0);
        % DEFININDO A POSIÇÃO DE BOIDS DENTRO DA FAIXA
        boid(i).position = mod(boid(i).position + universeLimits(2), universeLimits(2)); 
    end

end

