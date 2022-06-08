function target_points = A_star(CellSize,MaxCellX,MaxCellY,NumCells,ocu,pose,goal)
    
    % Posição inicial do robô
    RoboX = ceil(pose.x/CellSize);;
    RoboY = ceil(pose.y/CellSize);
    
    % Posição do objetivo (goal) no mapa
    GoalX = ceil(goal.x/CellSize);
    GoalY = ceil(goal.y/CellSize);
    
    % Plota posição do robô
    figure(1);
    cx = [RoboX RoboX RoboX+1 RoboX+1 RoboX];
    cy = [RoboY RoboY+1 RoboY+1 RoboY RoboY];
    plot(cx, cy, 'b' , 'LineWidth' , 5);
    
    % Plota a posição do objetivo
    figure(1)
    cx = [GoalX GoalX GoalX+1 GoalX+1 GoalX];
    cy = [GoalY GoalY+1 GoalY+1 GoalY GoalY];
    plot(cx, cy, 'g', 'LineWidth' , 5)
    
    %% Algoritmo A*
    
    start = (RoboY-1)*(MaxCellX+1)+RoboX;
    goal = (GoalY-1)*(MaxCellX+1)+GoalX;
    
    closedset = ocu';
    openset = start;
    for i=1:NumCells
        came_from(i) = 0;
        g_score(i) = 1e20;
        f_score(i) = 1e20;
    end
    g_score(start) = 0;
    f_score(start) = g_score(start) + heuristic_cost_estimate(start,goal,MaxCellX,MaxCellY);
    % count = 0;
    while ~isempty(openset)
        %     count = count + 1
        lowest_f_score = min(f_score(openset)); % Procura o menor valor de F
        index = find(f_score == lowest_f_score); % Acha o índice (nó) deste menor valor de F
        for i=1:size(index,2)
            if isempty(find(closedset == index(i)))
                current = index(i);
            end
        end
        if current == goal
            path = reconstruct_path(came_from,goal);
            break;
        end
        openset = openset(openset ~= current); % Remove a célula atual do vetor de células abertas
        closedset = [closedset current]; % Adiciona a célula atual do vetor de células fechadas
        % Indentifica as células vizinhas à célula atual
        neighbor_nodes = [];
        current_y_coordinate = floor(current/(MaxCellX+1)) + 1;
        current_x_coordinate = current - floor(current/(MaxCellX+1))*(MaxCellX+1);
        if (current_x_coordinate > 1) && (current_x_coordinate < MaxCellX+1) % Colunas do meio
            if (current_y_coordinate > 1) && (current_y_coordinate < MaxCellY+1) % Linhas do meio
                % 8 células vizinhas
                neighbor_nodes = [(current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-2)*(MaxCellX+1)+current_x_coordinate (current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate+1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate+1) current_y_coordinate*(MaxCellX+1)+(current_x_coordinate-1) current_y_coordinate*(MaxCellX+1)+current_x_coordinate current_y_coordinate*(MaxCellX+1)+(current_x_coordinate+1)];
            elseif current_y_coordinate == 1 % Primeira linha
                % 5 células vizinhas
                neighbor_nodes = [(current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate+1) current_y_coordinate*(MaxCellX+1)+(current_x_coordinate-1) current_y_coordinate*(MaxCellX+1)+current_x_coordinate current_y_coordinate*(MaxCellX+1)+(current_x_coordinate+1)];
            elseif current_y_coordinate == MaxCellY+1 % Última linha
                % 5 células vizinhas
                neighbor_nodes = [(current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-2)*(MaxCellX+1)+current_x_coordinate (current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate+1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate+1)];
            end
        elseif current_x_coordinate == 1 % Primeira coluna
            if (current_y_coordinate > 1) && (current_y_coordinate < MaxCellY+1) % Linhas do meio
                % 5 células vizinhas
                neighbor_nodes = [(current_y_coordinate-2)*(MaxCellX+1)+current_x_coordinate (current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate+1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate+1) current_y_coordinate*(MaxCellX+1)+current_x_coordinate current_y_coordinate*(MaxCellX+1)+(current_x_coordinate+1)];
            elseif current_y_coordinate == 1 % Primeira linha
                % 3 células vizinhas
                neighbor_nodes = [(current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate+1) current_y_coordinate*(MaxCellX+1)+current_x_coordinate current_y_coordinate*(MaxCellX+1)+(current_x_coordinate+1)];
            elseif current_y_coordinate == MaxCellY+1 % Última linha
                % 3 células vizinhas
                neighbor_nodes = [(current_y_coordinate-2)*(MaxCellX+1)+current_x_coordinate (current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate+1) (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate+1)];
            end
        elseif current_x_coordinate == MaxCellX+1 % Última coluna
            if (current_y_coordinate > 1) && (current_y_coordinate < MaxCellY+1) % Linhas do meio
                % 5 células vizinhas
                neighbor_nodes = [(current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-2)*(MaxCellX+1)+current_x_coordinate (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate-1) current_y_coordinate*(MaxCellX+1)+(current_x_coordinate-1) current_y_coordinate*(MaxCellX+1)+current_x_coordinate];
            elseif current_y_coordinate == 1 % Primeira linha
                % 3 células vizinhas
                neighbor_nodes = [(current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate-1) current_y_coordinate*(MaxCellX+1)+(current_x_coordinate-1) current_y_coordinate*(MaxCellX+1)+current_x_coordinate];
            elseif current_y_coordinate == MaxCellY+1 % Última linha
                % 3 células vizinhas
                neighbor_nodes = [(current_y_coordinate-2)*(MaxCellX+1)+(current_x_coordinate-1) (current_y_coordinate-2)*(MaxCellX+1)+current_x_coordinate (current_y_coordinate-1)*(MaxCellX+1)+(current_x_coordinate-1)];
            end
        end
        for i=1:size(neighbor_nodes,2)
            neighbor = neighbor_nodes(i);
            if ~isempty(find(closedset == neighbor))
                continue
            end
            tentative_g_score = g_score(current) + dist_between(current,neighbor,MaxCellX,MaxCellY);
            if (isempty(find(openset == neighbor))) || (tentative_g_score <= g_score(neighbor))
                came_from(neighbor) = current;
                g_score(neighbor) = tentative_g_score;
                f_score(neighbor) = g_score(neighbor) + heuristic_cost_estimate(neighbor,goal,MaxCellX,MaxCellY);
                if isempty(find(openset == neighbor))
                    openset = [openset neighbor];
                end
            end
        end
    end
    
    for i=1:length(closedset)
        figure(1)
        if mod(closedset(i),(MaxCellX+1)) == 0
            cx = [MaxCellX+1 MaxCellX+1 MaxCellX+2 MaxCellX+2 MaxCellX+1];
            cy = [closedset(i)/(MaxCellX+1) closedset(i)/(MaxCellX+1)+1 closedset(i)/(MaxCellX+1)+1 closedset(i)/(MaxCellX+1) closedset(i)/(MaxCellX+1)];
        else
            cx = [closedset(i)-floor(closedset(i)/(MaxCellX+1))*(MaxCellX+1) closedset(i)-floor(closedset(i)/(MaxCellX+1))*(MaxCellX+1) closedset(i)-floor(closedset(i)/(MaxCellX+1))*(MaxCellX+1)+1 closedset(i)-floor(closedset(i)/(MaxCellX+1))*(MaxCellX+1)+1 closedset(i)-floor(closedset(i)/(MaxCellX+1))*(MaxCellX+1)];
            cy = [floor(closedset(i)/(MaxCellX+1))+1 floor(closedset(i)/(MaxCellX+1))+2 floor(closedset(i)/(MaxCellX+1))+2 floor(closedset(i)/(MaxCellX+1))+1 floor(closedset(i)/(MaxCellX+1))+1];
        end
        plot(cx,cy,'color',[0.3 0.3 0.3],'LineWidth',3)
    end
    for i=1:length(ocu)
        figure(1)
        if mod(ocu(i),(MaxCellX+1)) == 0
            cx = [MaxCellX+1 MaxCellX+1 MaxCellX+2 MaxCellX+2 MaxCellX+1];
            cy = [ocu(i)/(MaxCellX+1) ocu(i)/(MaxCellX+1)+1 ocu(i)/(MaxCellX+1)+1 ocu(i)/(MaxCellX+1) ocu(i)/(MaxCellX+1)];
        else
            cx = [ocu(i)-floor(ocu(i)/(MaxCellX+1))*(MaxCellX+1) ocu(i)-floor(ocu(i)/(MaxCellX+1))*(MaxCellX+1) ocu(i)-floor(ocu(i)/(MaxCellX+1))*(MaxCellX+1)+1 ocu(i)-floor(ocu(i)/(MaxCellX+1))*(MaxCellX+1)+1 ocu(i)-floor(ocu(i)/(MaxCellX+1))*(MaxCellX+1)];
            cy = [floor(ocu(i)/(MaxCellX+1))+1 floor(ocu(i)/(MaxCellX+1))+2 floor(ocu(i)/(MaxCellX+1))+2 floor(ocu(i)/(MaxCellX+1))+1 floor(ocu(i)/(MaxCellX+1))+1];
        end
        plot(cx,cy,'r','LineWidth',3)
    end
    for i=1:length(openset)
        figure(1)
        if mod(openset(i),(MaxCellX+1)) == 0
            cx = [MaxCellX+1 MaxCellX+1 MaxCellX+2 MaxCellX+2 MaxCellX+1];
            cy = [openset(i)/(MaxCellX+1) openset(i)/(MaxCellX+1)+1 openset(i)/(MaxCellX+1)+1 openset(i)/(MaxCellX+1) openset(i)/(MaxCellX+1)];
        else
            cx = [openset(i)-floor(openset(i)/(MaxCellX+1))*(MaxCellX+1) openset(i)-floor(openset(i)/(MaxCellX+1))*(MaxCellX+1) openset(i)-floor(openset(i)/(MaxCellX+1))*(MaxCellX+1)+1 openset(i)-floor(openset(i)/(MaxCellX+1))*(MaxCellX+1)+1 openset(i)-floor(openset(i)/(MaxCellX+1))*(MaxCellX+1)];
            cy = [floor(openset(i)/(MaxCellX+1))+1 floor(openset(i)/(MaxCellX+1))+2 floor(openset(i)/(MaxCellX+1))+2 floor(openset(i)/(MaxCellX+1))+1 floor(openset(i)/(MaxCellX+1))+1];
        end
        plot(cx,cy,'y','LineWidth',3)
    end
    for i=1:length(path)
        figure(1)
        if mod(path(i),(MaxCellX+1)) == 0
            cx = [MaxCellX+1 MaxCellX+1 MaxCellX+2 MaxCellX+2 MaxCellX+1];
            cy = [path(i)/(MaxCellX+1) path(i)/(MaxCellX+1)+1 path(i)/(MaxCellX+1)+1 path(i)/(MaxCellX+1) path(i)/(MaxCellX+1)];
        else
            cx = [path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1) path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1) path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1)+1 path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1)+1 path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1)];
            cy = [floor(path(i)/(MaxCellX+1))+1 floor(path(i)/(MaxCellX+1))+2 floor(path(i)/(MaxCellX+1))+2 floor(path(i)/(MaxCellX+1))+1 floor(path(i)/(MaxCellX+1))+1];
        end
        plot(cx,cy,'m','LineWidth',3)
        
        % Target points (x and y)
        if mod(path(i),(MaxCellX+1)) == 0
            target_points.x(i) = (MaxCellX+1)*CellSize + CellSize/2;
            target_points.y(i) = (path(i)/(MaxCellX+1))*CellSize + CellSize/2;
        else
            target_points.x(i) = mod(path(i),(MaxCellX+1))*CellSize + CellSize/2;
            target_points.y(i) = (floor(path(i)/(MaxCellX+1))+1)*CellSize + CellSize/2;
        end
    end
    
    % Target points (th)
    for i=1:length(target_points.x)
        if i == length(target_points.x)
            target_points.th(i) = target_points.th(i-1);
        else
            target_points.th(i) = atan2(target_points.y(i+1)-target_points.y(i),target_points.x(i+1)-target_points.x(i));
        end
    end
    
end

