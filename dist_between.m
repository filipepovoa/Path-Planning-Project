function dist = dist_between(current,neighbor,MaxCellX,MaxCellY)
    
    % Coordenadas da célula atual
    current_y_coordinate = floor(current/(MaxCellX+1)) + 1;
    current_x_coordinate = current - floor(current/(MaxCellX+1))*(MaxCellX+1);
    
    % Coordenadas da célula vizinha
    neighbor_y_coordinate = floor(neighbor/(MaxCellX+1)) + 1;
    neighbor_x_coordinate = neighbor - floor(neighbor/(MaxCellX+1))*(MaxCellX+1);
    
    dist = sqrt((neighbor_x_coordinate-current_x_coordinate)^2 + (neighbor_y_coordinate-current_y_coordinate)^2);
    
end

