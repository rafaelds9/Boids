function [boid] = boid_update(boid, obstacle, obstRadius, radiusZones, ...
    forceParam, universeLimits, stdDev_dir)
%BOID_UPDATE Calculates each force involved in the flock's behaviour and
% sums them in order to find the
%   Detailed explanation goes here

    % Priorities to each behaviour
    S = forceParam(1);% Collision avoidance (other boids)
    M = forceParam(2);% Velocity Matching (other boids)
    K = forceParam(3);% Flock Centering (other boids)
    
    repulsionRadius = radiusZones(1);
    alignRadius = radiusZones(2);
    cohesionRadius = radiusZones(3);
    
    % for loop to calculate the new position and direction for each boid
    for i = 1:length(boid)
        %% CALCULATING THE DISTANCE BETWEEN THE BOID i and the obstacles
        distanceObst = zeros(length(obstacle), 1);
        for j = 1:length(obstacle)
            distanceObst(j) = norm(boid(i).position - obstacle(j).position);
        end
        
        %% OBSTACLE AVOIDANCE ROUTINE (PRIORITY)
        avoidObstIdx = find(distanceObst>0 & distanceObst<=obstRadius);
        numToAvoidObst = length(avoidObstIdx);
        sepForceObst = zeros(1, 2);
        if numToAvoidObst > 0
            sumRepelObst = zeros(1, 2);
            rij = zeros(1,2);
            for j = 1:numToAvoidObst
                rij = (obstacle(avoidObstIdx(j)).position - ...
                    boid(i).position);
                sumRepelObst = sumRepelObst + rij/norm(rij);
            end
            sepForceObst = -sumRepelObst./norm(sumRepelObst);
        end
        
        %% CALCULATING THE DISTANCE BETWEEN THE BOID i and the other boids
        distance = zeros(length(boid), 1);
        for j = 1:length(boid)
            distance(j) = norm(boid(i).position - boid(j).position);
        end
        %% SEPARATION BEHAVIOUR
        avoidIdx = find(distance>0 & distance<=repulsionRadius);
        numToAvoid = length(avoidIdx);
        sepForce = zeros(1, 2);
        if numToAvoid > 0 && numToAvoidObst == 0
            sumRepel = zeros(1, 2);
            rij = zeros(1,2);
            for j = 1:numToAvoid
                rij = (boid(avoidIdx(j)).position - boid(i).position);
                sumRepel = sumRepel + rij/norm(rij);
            end
            sepForce = -sumRepel./norm(sumRepel);
        end

        %% ALIGNMENT BEHAVIOUR
        alignIdx = find(distance>repulsionRadius & distance<=alignRadius);
        numToAlign = length(alignIdx);
        alignForce = zeros(1, 2);
        if ((numToAlign > 0) && (numToAvoid == 0) && (numToAvoidObst == 0))
            sumAlignDirections = zeros(1, 2);
            for j = 1:numToAlign
                sumAlignDirections = sumAlignDirections + ...
                    boid(alignIdx(j)).direction;
            end
           alignForce = sumAlignDirections./norm(sumAlignDirections);
        end

        %% COHESION/ATTRACTION BEHAVIOUR
        attractionIdx = find(distance>alignRadius & distance<= ...
            cohesionRadius);
        numAttractors = length(attractionIdx);
        cohesionForce = zeros(1, 2);
        if ((numAttractors > 0)&&(numToAvoid == 0)&&(numToAvoidObst == 0))
            sumAttract = zeros(1, 2);
            rij = zeros(1,2);
            for j = 1:numAttractors
                rij = (boid(attractionIdx(j)).direction - ...
                boid(i).direction);
                sumAttract = sumAttract + rij/norm(rij);
            end
            cohesionForce = sumAttract./norm(sumAttract);
        end
        
        %% Summing the forces with the direction
        
        % This is done differently than Couzin to consider the previous
        % boid direction
        boid(i).direction = boid(i).direction+sepForceObst+S*sepForce + ...
            M*alignForce + K*cohesionForce + stdDev_dir*randn(1,2);
        
        % Normalizing the direction
        boid(i).direction = boid(i).direction/norm(boid(i).direction);
            
        % Not considering the previous direction
        %boid(i).direction =  S*sepForce + M*alignForce + ...
        %    K*cohesionForce + stdDev_dir*randn(1,2);

        boid(i).position=boid(i).position + boid(i).direction.* ...
            boid(i).velocity;
        
        % ROI frontier treatment
        boid(i).position = mod(boid(i).position + universeLimits(2), ... 
            universeLimits(2)); 
    end

end

