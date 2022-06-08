%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Path planning project %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all; close all;

% Para propósito de legenda
figure(1)
l1 = plot([NaN,NaN],'b','LineWidth',3);
hold on
l2 = plot([NaN,NaN],'g','LineWidth',3);
l3 = plot([NaN,NaN],'r','LineWidth',3);
l4 = plot([NaN,NaN],'m','LineWidth',3);

legend('Posição do robô','Posição objetivo','Obstáculos','Caminho planejado')

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
GoalX = 40;
GoalY = 16;

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
% rn = walking_payoff*ones(NumCells,1);
% rn((GoalY-1)*(MaxCellX+1)-(MaxCellX+1-GoalX)) = goal_reward;
% rn(((MaxCellX+1)*MaxCellY)+1:(MaxCellX+1)*(MaxCellY+1)) = zeros(MaxCellX+1,1);
% for i=1:MaxCellY
%     for j=1:MaxCellX+1
%         index1 = find(ocupadas(:,1) == j);
%         index2 = find(ocupadas(:,2) == i+1); % Acha o índice da célula ocupada que está ao norte
%         for k=1:length(index2)
%             INDEX = find(index1 == index2(k));
%             if ~isempty(INDEX)
%                 rn((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
%                 break;
%             end
%         end
%         clear index1 index2 INDEX
%     end
% end
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
% rs = walking_payoff*ones(NumCells,1);
% rs((GoalY+1)*(MaxCellX+1)-(MaxCellX+1-GoalX)) = goal_reward;
% rs(1:MaxCellX+1) = zeros(MaxCellX+1,1);
% for i=2:MaxCellY+1
%     for j=1:MaxCellX+1
%         index1 = find(ocupadas(:,1) == j);
%         index2 = find(ocupadas(:,2) == i-1); % Acha o índice da célula ocupada que está ao sul
%         for k=1:length(index2)
%             INDEX = find(index1 == index2(k));
%             if ~isempty(INDEX)
%                 rs((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
%                 break;
%             end
%         end
%         clear index1 index2 INDEX
%     end
% end
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
% rl = walking_payoff*ones(NumCells,1);
% rl(GoalY*(MaxCellX+1)-(MaxCellX+1-(GoalX-1))) = goal_reward;
% for i=1:MaxCellY+1
%     rl(i*(MaxCellX+1)) = 0;
%     for j=1:MaxCellX
%         index1 = find(ocupadas(:,1) == j+1); % Acha o índice da célula ocupada que está ao leste
%         index2 = find(ocupadas(:,2) == i);
%         for k=1:length(index2)
%             INDEX = find(index1 == index2(k));
%             if ~isempty(INDEX)
%                 rl((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
%                 break;
%             end
%         end
%         clear index1 index2 INDEX
%     end
% end
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
% ro = walking_payoff*ones(NumCells,1);
% ro(GoalY*(MaxCellX+1)-(MaxCellX+1-(GoalX+1))) = goal_reward;
% for i=1:MaxCellY+1
%     ro((i-1)*(MaxCellX+1)+1) = 0;
%     for j=2:MaxCellX+1
%         index1 = find(ocupadas(:,1) == j-1); % Acha o índice da célula ocupada que está ao oeste
%         index2 = find(ocupadas(:,2) == i);
%         for k=1:length(index2)
%             INDEX = find(index1 == index2(k));
%             if ~isempty(INDEX)
%                 ro((i-1)*(MaxCellX+1)+j) = obstacle_payoff;
%                 break;
%             end
%         end
%         clear index1 index2 INDEX
%     end
% end
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
% Pn = North_Transition_Matrix(ocu,MaxCellX,MaxCellY,NumCells);
Pn = North_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
% Ação sul
% Ps = South_Transition_Matrix(ocu,MaxCellX,MaxCellY,NumCells);
Ps = South_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
% Ação leste
% Pl = East_Transition_Matrix(ocu,MaxCellX,MaxCellY,NumCells);
Pl = East_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
% Ação oeste
% Po = West_Transition_Matrix(ocu,MaxCellX,MaxCellY,NumCells);
Po = West_Transition_Matrix(MaxCellX,MaxCellY,NumCells);
% 4 ações: norte, sul, leste e oeste respectivamente
P.norte = Pn;
P.sul = Ps;
P.leste = Pl;
P.oeste = Po;

% Discount factor - este valor deve estar contido em ]0,1[
% gama = 0.99;
gama = 0.89;

%% Calcula a política ótima para todos os estados
% Computa os valores para o vetor V
tic
V = MDP_value_iteration(gama,r,P,NumCells);
% Computa a política ótima
pi = zeros(NumCells,1);
for i=1:NumCells
    pi(i) = MDP_policy(r,P,i,V);
end
delta_t = toc

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
            if pi((i-1)*(MaxCellX+1)+j) == 1 % Plota seta para o norte
                plot([(j-1)+0.5+offset (j-1)+0.5+offset],[(i-1)+0.1+offset (i-1)+0.9+offset],'r')
                plot([(j-1)+0.5+offset (j-1)+0.5+0.4*sind(45)+offset],[(i-1)+0.9+offset (i-1)+0.9-0.4*cosd(45)+offset],'r')
                plot([(j-1)+0.5+offset (j-1)+0.5-0.4*sind(45)+offset],[(i-1)+0.9+offset (i-1)+0.9-0.4*cosd(45)+offset],'r')
            elseif pi((i-1)*(MaxCellX+1)+j) == 2 % Plota seta para o sul
                plot([(j-1)+0.5+offset (j-1)+0.5+offset],[(i-1)+0.9+offset (i-1)+0.1+offset],'r')
                plot([(j-1)+0.5+offset (j-1)+0.5+0.4*sind(45)+offset],[(i-1)+0.1+offset (i-1)+0.1+0.4*cosd(45)+offset],'r')
                plot([(j-1)+0.5+offset (j-1)+0.5-0.4*sind(45)+offset],[(i-1)+0.1+offset (i-1)+0.1+0.4*cosd(45)+offset],'r')
            elseif pi((i-1)*(MaxCellX+1)+j) == 3 % Plota seta para o leste
                plot([(j-1)+0.1+offset (j-1)+0.9+offset],[(i-1)+0.5+offset (i-1)+0.5+offset],'r')
                plot([(j-1)+0.9+offset (j-1)+0.9-0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5+0.4*sind(45)+offset],'r')
                plot([(j-1)+0.9+offset (j-1)+0.9-0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5-0.4*sind(45)+offset],'r')
            elseif pi((i-1)*(MaxCellX+1)+j) == 4 % Plota seta para o oeste
                plot([(j-1)+0.9+offset (j-1)+0.1+offset],[(i-1)+0.5+offset (i-1)+0.5+offset],'r')
                plot([(j-1)+0.1+offset (j-1)+0.1+0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5+0.4*sind(45)+offset],'r')
                plot([(j-1)+0.1+offset (j-1)+0.1+0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5-0.4*sind(45)+offset],'r')
            end
        end
        clear index1 index2 INDEX boolean
    end
end
set(gca,'FontSize',20)
set(gca, 'FontName', 'Times New Roman')
set(gcf,'Position',[400 75 1100 900])
xlabel('Coordenada x da célula')
ylabel('Coordenada y da célula')
% figure(1)
% offset = 1;
% for i=1:MaxCellY+1
%     for j=1:MaxCellX+1
%         if pi((i-1)*(MaxCellX+1)+j) == 1 % Plota seta para o norte
%             plot([(j-1)+0.5+offset (j-1)+0.5+offset],[(i-1)+0.1+offset (i-1)+0.9+offset],'r')
%             plot([(j-1)+0.5+offset (j-1)+0.5+0.4*sind(45)+offset],[(i-1)+0.9+offset (i-1)+0.9-0.4*cosd(45)+offset],'r')
%             plot([(j-1)+0.5+offset (j-1)+0.5-0.4*sind(45)+offset],[(i-1)+0.9+offset (i-1)+0.9-0.4*cosd(45)+offset],'r')
%         elseif pi((i-1)*(MaxCellX+1)+j) == 2 % Plota seta para o sul
%             plot([(j-1)+0.5+offset (j-1)+0.5+offset],[(i-1)+0.9+offset (i-1)+0.1+offset],'r')
%             plot([(j-1)+0.5+offset (j-1)+0.5+0.4*sind(45)+offset],[(i-1)+0.1+offset (i-1)+0.1+0.4*cosd(45)+offset],'r')
%             plot([(j-1)+0.5+offset (j-1)+0.5-0.4*sind(45)+offset],[(i-1)+0.1+offset (i-1)+0.1+0.4*cosd(45)+offset],'r')
%         elseif pi((i-1)*(MaxCellX+1)+j) == 3 % Plota seta para o leste
%             plot([(j-1)+0.1+offset (j-1)+0.9+offset],[(i-1)+0.5+offset (i-1)+0.5+offset],'r')
%             plot([(j-1)+0.9+offset (j-1)+0.9-0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5+0.4*sind(45)+offset],'r')
%             plot([(j-1)+0.9+offset (j-1)+0.9-0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5-0.4*sind(45)+offset],'r')
%         elseif pi((i-1)*(MaxCellX+1)+j) == 4 % Plota seta para o oeste
%             plot([(j-1)+0.9+offset (j-1)+0.1+offset],[(i-1)+0.5+offset (i-1)+0.5+offset],'r')
%             plot([(j-1)+0.1+offset (j-1)+0.1+0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5+0.4*sind(45)+offset],'r')
%             plot([(j-1)+0.1+offset (j-1)+0.1+0.4*cosd(45)+offset],[(i-1)+0.5+offset (i-1)+0.5-0.4*sind(45)+offset],'r')
%         end
%     end
% end
% set(gca,'FontSize',18)
% set(gcf,'Position',[400 75 1100 900])

Goal = [GoalX; GoalY];
Target = [RoboX; RoboY];
while [Target-Goal]'*[Target-Goal] > 0
    if pi((Target(2)-1)*(MaxCellX+1)+Target(1)) == 1 % Ação norte
        Target(2) = Target(2)+1;
    elseif pi((Target(2)-1)*(MaxCellX+1)+Target(1)) == 2 % Ação sul
        Target(2) = Target(2)-1;
    elseif pi((Target(2)-1)*(MaxCellX+1)+Target(1)) == 3 % Ação leste
        Target(1) = Target(1)+1;
    elseif pi((Target(2)-1)*(MaxCellX+1)+Target(1)) == 4 % Ação oeste
        Target(1) = Target(1)-1;
    end
    figure(1);
    cx = [Target(1) Target(1) Target(1)+1 Target(1)+1 Target(1)];
    cy = [Target(2) Target(2)+1 Target(2)+1 Target(2) Target(2)];
    plot(cx, cy, 'm' , 'LineWidth' , 3);
end