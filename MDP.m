function target_points = MDP(CellSize,MaxCellX,MaxCellY,NumCells,ocupadas,ocu,pose,goal)
    
    % Posição inicial do robô
    RoboX = ceil(pose.x/CellSize);
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
    
    %% Computa a função de payoff
    % ocupadas é coluna vs linha
    obstacle_payoff = -100; % Pagamento relativo ao topar com um obstáculo
    walking_payoff = -1; % Pagamento relativo a andar
    goal_reward = 10; % Recompensa relativo ao alcance do objetivo
    % Ação norte
    rn = walking_payoff*ones(NumCells,1);
    rn((GoalY-1)*(MaxCellX+1)-(MaxCellX+1-GoalX)) = goal_reward;
    rn(((MaxCellX+1)*MaxCellY)+1:(MaxCellX+1)*(MaxCellY+1)) = zeros(MaxCellX+1,1);
    for i=1:MaxCellY
        for j=1:MaxCellX+1
            north_cell = i*(MaxCellX+1)+j;
            if ~isempty(find(ocu == north_cell))
                rn((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
            end
        end
    end
    % Ação sul
    rs = walking_payoff*ones(NumCells,1);
    rs((GoalY+1)*(MaxCellX+1)-(MaxCellX+1-GoalX)) = goal_reward;
    rs(1:MaxCellX+1) = zeros(MaxCellX+1,1);
    for i=2:MaxCellY+1
        for j=1:MaxCellX+1
            south_cell = (i-2)*(MaxCellX+1)+j;
            if ~isempty(find(ocu == south_cell))
                rs((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
            end
        end
    end
    % Ação leste
    rl = walking_payoff*ones(NumCells,1);
    rl(GoalY*(MaxCellX+1)-(MaxCellX+1-(GoalX-1))) = goal_reward;
    for i=1:MaxCellY+1
        rl(i*(MaxCellX+1)) = 0;
        for j=1:MaxCellX
            east_cell = (i-1)*(MaxCellX+1)+j+1;
            if ~isempty(find(ocu == east_cell))
                rl((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
            end
        end
    end
    % Ação oeste
    ro = walking_payoff*ones(NumCells,1);
    ro(GoalY*(MaxCellX+1)-(MaxCellX+1-(GoalX+1))) = goal_reward;
    for i=1:MaxCellY+1
        ro((i-1)*(MaxCellX+1)+1) = 0;
        for j=2:MaxCellX+1
            west_cell = (i-1)*(MaxCellX+1)+j-1;
            if ~isempty(find(ocu == west_cell))
                ro((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
            end
        end
    end
    % 4 ações: norte, sul, leste e oeste respectivamente
    r = [rn rs rl ro];
    
    %% Cria a matriz de transição de estados
    % Ação norte
    Pn = North_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
    % Ação sul
    Ps = South_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
    % Ação leste
    Pl = East_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
    % Ação oeste
    Po = West_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
    % 4 ações: norte, sul, leste e oeste respectivamente
    P.norte = Pn;
    P.sul = Ps;
    P.leste = Pl;
    P.oeste = Po;
    
    % Discount factor (este valor deve estar contido em ]0,1[
    % gama = 0.99;
    gama = 0.89;
    
    %% Calcula a política ótima para todos os estados
    % Computa os valores para o vetor V
    disp('Calculando rotas ...')
    V = MDP_value_iteration(gama,r,P,NumCells);
    % Computa a política ótima
    PI = zeros(NumCells,1);
    for i=1:NumCells
        PI(i) = MDP_policy(r,P,i,V);
    end
    disp('Rota encontrada!')
    
    %% Plota os resultados
    figure(1)
    offset = 1;
    for i=1:MaxCellY+1
        for j=1:MaxCellX+1
            boolean = 0;
            index1 = find(ocupadas(:,1) == j);
            index2 = find(ocupadas(:,2) == i);
            for k=1:length(index2)
                INDEX = find(index1 == index2(k));
                if ~isempty(INDEX)
                    boolean = 1;
                    break;
                end
            end
            if boolean == 1
                % Não plota nada
            else
                if PI((i-1)*(MaxCellX+1)+j) == 1 % Plota seta para o norte
                    plot([(j-1)+0.5+offset (j-1)+0.5+offset],[(i-1)+0.1+offset (i-1)+0.9+offset],'r')
                    plot([(j-1)+0.5+offset (j-1)+0.5+0.4*sind(45)+offset],[(i-1)+0.9+offset (i-1)+0.9-0.4*cosd(45)+offset],'r')
                    plot([(j-1)+0.5+offset (j-1)+0.5-0.4*sind(45)+offset],[(i-1)+0.9+offset (i-1)+0.9-0.4*cosd(45)+offset],'r')
                elseif PI((i-1)*(MaxCellX+1)+j) == 2 % Plota seta para o sul
                    plot([(j-1)+0.5+offset (j-1)+0.5+offset],[(i-1)+0.9+offset (i-1)+0.1+offset],'r')
                    plot([(j-1)+0.5+offset (j-1)+0.5+0.4*sind(45)+offset],[(i-1)+0.1+offset (i-1)+0.1+0.4*cosd(45)+offset],'r')
                    plot([(j-1)+0.5+offset (j-1)+0.5-0.4*sind(45)+offset],[(i-1)+0.1+offset (i-1)+0.1+0.4*cosd(45)+offset],'r')
                elseif PI((i-1)*(MaxCellX+1)+j) == 3 % Plota seta para o leste
                    plot([(j-1)+0.1+offset (j-1)+0.9+offset],[(i-1)+0.5+offset (i-1)+0.5+offset],'r')
                    plot([(j-1)+0.9+offset (j-1)+0.9-0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5+0.4*sind(45)+offset],'r')
                    plot([(j-1)+0.9+offset (j-1)+0.9-0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5-0.4*sind(45)+offset],'r')
                elseif PI((i-1)*(MaxCellX+1)+j) == 4 % Plota seta para o oeste
                    plot([(j-1)+0.9+offset (j-1)+0.1+offset],[(i-1)+0.5+offset (i-1)+0.5+offset],'r')
                    plot([(j-1)+0.1+offset (j-1)+0.1+0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5+0.4*sind(45)+offset],'r')
                    plot([(j-1)+0.1+offset (j-1)+0.1+0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5-0.4*sind(45)+offset],'r')
                end
            end
            clear index1 index2 INDEX boolean
        end
    end
    set(gca,'FontSize',18)
    set(gcf,'Position',[400 75 1100 900])
    
    Goal = [GoalX; GoalY];
    Target = [RoboX; RoboY];
    count = 0;
    while [Target-Goal]'*[Target-Goal] > 0
        count = count + 1;
        if PI((Target(2)-1)*(MaxCellX+1)+Target(1)) == 1 % Ação norte
            Target(2) = Target(2)+1;
            target_points(count).th = pi/2;
        elseif PI((Target(2)-1)*(MaxCellX+1)+Target(1)) == 2 % Ação sul
            Target(2) = Target(2)-1;
            target_points(count).th = -pi/2;
        elseif PI((Target(2)-1)*(MaxCellX+1)+Target(1)) == 3 % Ação leste
            Target(1) = Target(1)+1;
            target_points(count).th = 0;
        elseif PI((Target(2)-1)*(MaxCellX+1)+Target(1)) == 4 % Ação oeste
            Target(1) = Target(1)-1;
            target_points(count).th = pi;
        end
        target_points(count).x = (Target(1)+0.5)*CellSize;
        target_points(count).y = (Target(2)+0.5)*CellSize;
        figure(1);
        cx = [Target(1) Target(1) Target(1)+1 Target(1)+1 Target(1)];
        cy = [Target(2) Target(2)+1 Target(2)+1 Target(2) Target(2)];
        plot(cx, cy, 'm' , 'LineWidth' , 5);
    end
    drawnow;
    
end

