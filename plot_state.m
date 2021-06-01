function [] = plot_state(boid, obstacle, universeLimits, boidSize, ...
    obstSize, it)
    
    ss = get(0, 'ScreenSize');
    figHandle=figure(1);
    set(figHandle,'Position',[ss(1) ss(2) 0.9*ss(4) 0.9*ss(4)], ...
        'Color', [1 1 1], 'NextPlot','Replace');

    clf;
    grid minor;
    hold on;
    %%
    for i = 1:length(boid)
        x = [boid(i).position(1)-boidSize(1) boid(i).position(1)+ ...
                boidSize(1) boid(i).position(1)-boidSize(1) ...
                boid(i).position(1)-boidSize(1)];
            
        y = [boid(i).position(2)-boidSize(2) boid(i).position(2) ...
                boid(i).position(2)+boidSize(2) boid(i).position(2)+ ...
                boidSize(2)];
    
        boid_drawing(i) = patch(x,y,'k');
        
        angle_rotation_deg = atand(boid(i).direction(2)/ ...
            boid(i).direction(1));
        
        rotate(boid_drawing(i),[0 0 1], angle_rotation_deg, ...
            [boid(i).position(1) boid(i).position(2) 0]);

    end
    
    for i = 1:length(obstacle)
        x = obstacle(i).position(1);
        y = obstacle(i).position(2);
        %plot(x, y,'s','LineWidth',2,'MarkerEdgeColor','k', ...
        %    'MarkerFaceColor',[.49 1 .63],'MarkerSize', 4*obstSize );
        rectangle('Position', [x y obstSize obstSize], 'FaceColor', ...
            [.49 1 .63], 'EdgeColor', 'k')
    end
    
    strTitle = "Boids - Iteration nº " + it;
    title(strTitle);
    
    xlim(universeLimits);
    ylim(universeLimits);
    hold off;
end

