classdef Boid
    
    % Defines the Boid class containing the attributes "position", 
    % "direction" and "velocity"
    
    properties
    	position %s
        direction %dir
        velocity %vel
    end
    
    
    
    methods
        % Creates a boid
        % Retorna um objeto
        function obj = Boid(s, dir, vel)
            obj.position = s;
            obj.direction = dir;
            obj.velocity = vel;
        end
        
        % Apenas para teste
        function [] = showPos(obj) 
            disp(obj.position)
        end
        
        
        
        % Calculates ...
        
        % Calculates ...
        
        % Updates boid
        
    end
    
end