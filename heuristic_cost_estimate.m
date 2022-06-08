function cost = heuristic_cost_estimate(current,goal,MaxCellX,MaxCellY)
    
    % Coordenadas da c�lula atual
    current_y_coordinate = floor(current/(MaxCellX+1)) + 1;
    current_x_coordinate = current - floor(current/(MaxCellX+1))*(MaxCellX+1);
    
    % Coordenadas da c�lula objetivo
    goal_y_coordinate = floor(goal/(MaxCellX+1)) + 1;
    goal_x_coordinate = goal - floor(goal/(MaxCellX+1))*(MaxCellX+1);
    
    % Dist�ncia euclidiana entre os pontos atual e objetivo
    cost = sqrt((goal_x_coordinate-current_x_coordinate)^2 + (goal_y_coordinate-current_y_coordinate)^2);
    
end

