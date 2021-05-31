classdef Boid
    % Defines the Boid class containing the attributes "position", 
    % "direction" and its methods
    properties
    	position %s
        direction %dir
        velocity %vel
    end
    
    methods
        % Creates a boid
        function obj = Boid(s, dir, vel)
            obj.position = s;
            obj.direction = dir;
            obj.velocity = vel;
        end
        %
        function [] = testPrint(obj)
            disp(obj.position)
        end
    end
end