%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% A star planning project %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all; close all;

% Para propósito de legenda
figure(1)
l1 = plot([NaN,NaN],'b','LineWidth',3);
hold on
l2 = plot([NaN,NaN],'g','LineWidth',3);
l3 = plot([NaN,NaN],'r','LineWidth',3);
% l4 = plot([NaN,NaN],'color',[0.3 0.3 0.3],'LineWidth',3);
% l5 = plot([NaN,NaN],'color',[1 0.5490 0],'LineWidth',3);
% l6 = plot([NaN,NaN],'m','LineWidth',3);

legend('Posição do robô','Posição objetivo','Obstáculos')
% legend('Posição do robô','Posição objetivo','Obstáculos','Células fechadas','Células abertas','Caminho planejado')

%% Setup inicial

% Cria o mapa
mapa = [];
mapa = [mapa; 0       0    0 2280   1       0         0];
mapa = [mapa; 0    2280  920 2280   0       1      2280];
mapa = [mapa; 920  2280  920 3200   1       0       920];
mapa = [mapa; 920  3200 4190 3200   0       1      3200];
mapa = [mapa; 4190 3200 4190 2365   1       0      4190];
mapa = [mapa; 4190 2365 4680 2365   0       1      2365];
mapa = [mapa; 4680 2365 4680  650   1       0      4680];
mapa = [mapa; 4680  650 4030    0  2.4814 -2.4814 10000];
mapa = [mapa; 4030    0    0    0   0       1         0];
mapa = [mapa; 2000  500 2400  500   0       1       500]; % Obstáculos
mapa = [mapa; 2400  500 2400 2500   1       0      2400]; % Obstáculos
mapa = [mapa; 2400 2500 2800 2500   0       1      2500]; % Obstáculos
mapa = [mapa; 2000  600 2300  600   0       1       600]; % Obstáculos
mapa = [mapa; 2300  600 2300 2600   1       0      2300]; % Obstáculos
mapa = [mapa; 2300 2600 2800 2600   0       1      2600]; % Obstáculos
mapa = [mapa; 2000  400 2500  400   0       1       400]; % Obstáculos
mapa = [mapa; 2500  400 2500 2400   1       0      2500]; % Obstáculos
mapa = [mapa; 2500 2400 2800 2400   0       1      2400]; % Obstáculos

% Limites do mapa
MinX = 0;
MaxX = 4680;
MinY = 0;
MaxY = 3200;

% Define tamanho da celula
CellSize = 100;   % mm

% Array contendo o mapa
MaxCellX = ceil(MaxX/CellSize);
MaxCellY = ceil(MaxY/CellSize);
NumCells = (MaxCellX+1)*(MaxCellY+1);

% Plota o mapa com as células ocupadas
ocupadas = plotamapa(mapa, CellSize, MaxCellX, MaxCellY);

for i=1:size(ocupadas,1)
    ocu(i) = (ocupadas(i,2)-1)*(MaxCellX+1)+ocupadas(i,1);
end
ocu = unique(ocu)';

% Posição inicial do robô
RoboX = 10; % 1000 no mapa
RoboY = 16; % 1600 no mapa

% Posição do objetivo (goal) no mapa
GoalX = 40; % 4000 no mapa
GoalY = 16; % 1600 no mapa

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

set(gca,'FontSize',20)
set(gca, 'FontName', 'Times New Roman')
set(gcf,'Position',[400 75 1100 900])
xlabel('Coordenada x da célula')
ylabel('Coordenada y da célula')
pause(1)

%% Algoritmo A*

start = (RoboY-1)*(MaxCellX+1)+RoboX;
goal = (GoalY-1)*(MaxCellX+1)+GoalX;

tic

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

delta_t = toc

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
    plot(cx,cy,'color',[1 0.5490 0],'LineWidth',2)
end
target_points.x = [];
target_points.y = [];
target_points.th = [];
for i=1:length(path)
    figure(1)
    if mod(path(i),(MaxCellX+1)) == 0
        cx = [MaxCellX+1 MaxCellX+1 MaxCellX+2 MaxCellX+2 MaxCellX+1];
        cy = [path(i)/(MaxCellX+1) path(i)/(MaxCellX+1)+1 path(i)/(MaxCellX+1)+1 path(i)/(MaxCellX+1) path(i)/(MaxCellX+1)];
    else
        cx = [path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1) path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1) path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1)+1 path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1)+1 path(i)-floor(path(i)/(MaxCellX+1))*(MaxCellX+1)];
        cy = [floor(path(i)/(MaxCellX+1))+1 floor(path(i)/(MaxCellX+1))+2 floor(path(i)/(MaxCellX+1))+2 floor(path(i)/(MaxCellX+1))+1 floor(path(i)/(MaxCellX+1))+1];
    end
    plot(cx,cy,'m','LineWidth',4)
    pause(0.05)
    drawnow
    % Target points (x and y)
    if mod(path(i),(MaxCellX+1)) == 0
        target_points(i).x = (MaxCellX+1)*CellSize + CellSize/2;
        target_points(i).y = (path(i)/(MaxCellX+1))*CellSize + CellSize/2;
    else
        target_points(i).x = mod(path(i),(MaxCellX+1))*CellSize + CellSize/2;
        target_points(i).y = (floor(path(i)/(MaxCellX+1))+1)*CellSize + CellSize/2;
    end
end

% Target points (th)
for i=1:length(target_points)
    if i == length(target_points)
        target_points(i).th = target_points(i-1).th;
    else
        target_points(i).th = atan2(target_points(i+1).y-target_points(i).y,target_points(i+1).x-target_points(i).x);
    end
end