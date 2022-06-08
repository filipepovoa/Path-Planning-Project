function cost = heuristic_cost_estimate(current,goal,MaxCellX,MaxCellY)
    
    % Coordenadas da célula atual
    current_y_coordinate = floor(current/(MaxCellX+1)) + 1;
    current_x_coordinate = current - floor(current/(MaxCellX+1))*(MaxCellX+1);
    
    % Coordenadas da célula objetivo
    goal_y_coordinate = floor(goal/(MaxCellX+1)) + 1;
    goal_x_coordinate = goal - floor(goal/(MaxCellX+1))*(MaxCellX+1);
    
    % Distância euclidiana entre os pontos atual e objetivo
    cost = sqrt((goal_x_coordinate-current_x_coordinate)^2 + (goal_y_coordinate-current_y_coordinate)^2);
    
end

