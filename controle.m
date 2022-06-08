%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Controle do robô para alcance do objetivo ¨%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear all; close all;

%% Setup inicial
    
% Cria o mapa

% Old map
% mapa = [];
% mapa = [mapa; 0       0    0 2280   1       0         0];
% mapa = [mapa; 0    2280  920 2280   0       1      2280];
% mapa = [mapa; 920  2280  920 3200   1       0       920];
% mapa = [mapa; 920  3200 4190 3200   0       1      3200];
% mapa = [mapa; 4190 3200 4190 2365   1       0      4190];
% mapa = [mapa; 4190 2365 4680 2365   0       1      2365];
% mapa = [mapa; 4680 2365 4680  650   1       0      4680];
% mapa = [mapa; 4680  650 4030    0  2.4814 -2.4814 10000];
% mapa = [mapa; 4030    0    0    0   0       1         0];
% mapa = [mapa; 2000  500 2400  500   0       1       500]; % Obstáculos
% mapa = [mapa; 2400  500 2400 2500   1       0      2400]; % Obstáculos
% mapa = [mapa; 2400 2500 2800 2500   0       1      2500]; % Obstáculos
% mapa = [mapa; 2000  600 2300  600   0       1       600]; % Obstáculos
% mapa = [mapa; 2300  600 2300 2600   1       0      2300]; % Obstáculos
% mapa = [mapa; 2300 2600 2800 2600   0       1      2600]; % Obstáculos
% mapa = [mapa; 2000  400 2500  400   0       1       400]; % Obstáculos
% mapa = [mapa; 2500  400 2500 2400   1       0      2500]; % Obstáculos
% mapa = [mapa; 2500 2400 2800 2400   0       1      2400]; % Obstáculos

% Wheelchair or P3DX
isWheelchair = 1;

if isWheelchair
    % Wheelchair map
    mapa = [];
    mapa = [mapa;       0       0       0 15.1999       1       0       0];
    mapa = [mapa;       0 15.1999  6.1333 15.1999       0       1 15.1999];
    mapa = [mapa;  6.1333 15.1999  6.1333 21.3332       1       0  6.1333];
    mapa = [mapa;  6.1333 21.3332 27.9332 21.3332       0       1 21.3332];
    mapa = [mapa; 27.9332 21.3332 27.9332 15.7666       1       0 27.3332];
    mapa = [mapa; 27.9332 15.7666 31.1999 15.7666       0       1 15.7666];
    mapa = [mapa; 31.1999 15.7666 31.1999  4.3333       1       0 31.1999];
    mapa = [mapa; 31.1999  4.3333 26.8666       0       1      -1 26.8666];
    mapa = [mapa; 26.8666       0       0       0       0       1       0];
    mapa = [mapa; 13.3333  3.3333      16  3.3333       0       1  3.3333]; % Obstáculos
    mapa = [mapa;      16  3.3333      16 16.6666       1       0      16]; % Obstáculos
    mapa = [mapa;      16 16.6666 18.6667 16.6666       0       1 16.6666]; % Obstáculos
    mapa = [mapa; 13.3333       4 15.3333       4       0       1       4]; % Obstáculos
    mapa = [mapa; 15.3333       4 15.3333 17.3333       1       0 15.3333]; % Obstáculos
    mapa = [mapa; 15.3333 17.3333 18.6667 17.3333       0       1 17.3333]; % Obstáculos
    mapa = [mapa; 13.3333  2.6666 16.6667  2.6666       0       1  2.6666]; % Obstáculos
    mapa = [mapa; 16.6667  2.6666 16.6667 15.9999       1       0 16.6667]; % Obstáculos
    mapa = [mapa; 16.6667 15.9999 18.6667 15.9999       0       1 15.9999]; % Obstáculos
    
    % Limites do mapa
    MinX = 0;
    MaxX = 31.1999;
    MinY = 0;
    MaxY = 21.3332;
    
    % Define tamanho da celula
    CellSize = 0.6667;   % m
    
    % Array contendo o mapa
    MaxCellX = ceil(MaxX/CellSize);
    MaxCellY = ceil(MaxY/CellSize);
    NumCells = (MaxCellX+1)*(MaxCellY+1);
else
    % P3dx map
    mapa = [];
    mapa = [mapa;       0       0       0 15.1999       1       0       0];
    mapa = [mapa;       0 15.1999  6.1333 15.1999       0       1 15.1999];
    mapa = [mapa;  6.1333 15.1999  6.1333 21.3332       1       0  6.1333];
    mapa = [mapa;  6.1333 21.3332 27.9332 21.3332       0       1 21.3332];
    mapa = [mapa; 27.9332 21.3332 27.9332 15.7666       1       0 27.3332];
    mapa = [mapa; 27.9332 15.7666 31.1999 15.7666       0       1 15.7666];
    mapa = [mapa; 31.1999 15.7666 31.1999  4.3333       1       0 31.1999];
    mapa = [mapa; 31.1999  4.3333 26.8666       0       1      -1 26.8666];
    mapa = [mapa; 26.8666       0       0       0       0       1       0];
    mapa = [mapa; 13.3333  3.3333      16  3.3333       0       1  3.3333]; % Obstáculos
    mapa = [mapa;      16  3.3333      16 16.6666       1       0      16]; % Obstáculos
    mapa = [mapa;      16 16.6666 18.6667 16.6666       0       1 16.6666]; % Obstáculos
    mapa = [mapa; 13.3333       4 15.3333       4       0       1       4]; % Obstáculos
    mapa = [mapa; 15.3333       4 15.3333 17.3333       1       0 15.3333]; % Obstáculos
    mapa = [mapa; 15.3333 17.3333 18.6667 17.3333       0       1 17.3333]; % Obstáculos
    mapa = [mapa; 13.3333  2.6666 16.6667  2.6666       0       1  2.6666]; % Obstáculos
    mapa = [mapa; 16.6667  2.6666 16.6667 15.9999       1       0 16.6667]; % Obstáculos
    mapa = [mapa; 16.6667 15.9999 18.6667 15.9999       0       1 15.9999]; % Obstáculos
    
    % Limites do mapa
    MinX = 0;
    MaxX = 31.1999;
    MinY = 0;
    MaxY = 21.3332;
    
    % Define tamanho da celula
    CellSize = 0.6667;   % m
    
    % Array contendo o mapa
    MaxCellX = ceil(MaxX/CellSize);
    MaxCellY = ceil(MaxY/CellSize);
    NumCells = (MaxCellX+1)*(MaxCellY+1);
end

% Plota o mapa com as células ocupadas
ocupadas = plotamapa(mapa, CellSize, MaxCellX, MaxCellY);

for i=1:size(ocupadas,1)
    ocu(i) = (ocupadas(i,2)-1)*(MaxCellX+1)+ocupadas(i,1);
end
ocu = unique(ocu)';

vrep = remApi('remoteApi');
vrep.simxFinish(-1);
% Inicializa conexão
clientID = vrep.simxStart('127.0.0.1',19999,true,true,5000,5);

% Testa para ver se a conexão foi bem sucedida
if (clientID ~= -1)
    disp('Connected to remote API server')
else
    disp('Connection not succesful')
    return;
end

if isWheelchair
    % WHEELCHAIR
    
    % Pega o handle dos objetos no V-REP
    [err,wheelchair] = vrep.simxGetObjectHandle(clientID,'wheelchair',vrep.simx_opmode_oneshot_wait);
    [err,leftMotor] = vrep.simxGetObjectHandle(clientID,'wheelchair_leftMotor',vrep.simx_opmode_oneshot_wait);
    [err,rightMotor] = vrep.simxGetObjectHandle(clientID,'wheelchair_rightMotor',vrep.simx_opmode_oneshot_wait);
    
    [err,Position] = vrep.simxGetObjectPosition(clientID,wheelchair,-1,vrep.simx_opmode_streaming);
    pause(1)
    [err,Position] = vrep.simxGetObjectPosition(clientID,wheelchair,-1,vrep.simx_opmode_buffer);
    [err,Orientation] = vrep.simxGetObjectOrientation(clientID,wheelchair,-1,vrep.simx_opmode_streaming);
    pause(1)
    [err,Orientation] = vrep.simxGetObjectOrientation(clientID,wheelchair,-1,vrep.simx_opmode_buffer);
    
    % Distância entre o eixo traseiro e o frame
%     dist_offset = 47.2; % [mm]
    dist_offset = 0.3147; % [m]
    % Ângulo da cadeira de rodas
    angle_offset = pi/2;
    
    % Posição da cadeira
    pose.x = round(Position(1)-dist_offset)-CellSize/2; % [m]
    pose.y = round(Position(2))-CellSize/2; % [m]
    pose.th = round(Orientation(3)+angle_offset); % [rad]
else
    % P3DX
    
    % Pega o handle dos objetos no V-REP
    [err,p3dx] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx',vrep.simx_opmode_oneshot_wait);
    [err,leftMotor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',vrep.simx_opmode_oneshot_wait);
    [err,rightMotor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',vrep.simx_opmode_oneshot_wait);
    
    % Pega o valor de posição
    [err,Position] = vrep.simxGetObjectPosition(clientID,p3dx,-1,vrep.simx_opmode_streaming);
    pause(1)
    [err,Position] = vrep.simxGetObjectPosition(clientID,p3dx,-1,vrep.simx_opmode_buffer);
    [err,Orientation] = vrep.simxGetObjectOrientation(clientID,p3dx,-1,vrep.simx_opmode_streaming);
    pause(1)
    [err,Orientation] = vrep.simxGetObjectOrientation(clientID,p3dx,-1,vrep.simx_opmode_buffer);
    
    % Posição do robô
    pose.x = round(Position(1))-CellSize/2; % [m]
    pose.y = round(Position(2))-CellSize/2; % [m]
    pose.th = round(Orientation(3)); % [rad]
end

% Posição do objetivo
goal.x = 26.6666; % [m]
goal.y = 10.6666; % [m]

% target_points = MDP(mapa,CellSize,MaxCellX,MaxCellY,NumCells,ocupadas,ocu,pose,goal);
target_points = A_star(CellSize,MaxCellX,MaxCellY,NumCells,ocu,pose,goal);
% radius = 4; % Raio do círculo
% target_points = generate_circle(Position,radius);
% len = 3; % Lado do quadrado
% target_points = generate_square(Position,len);
% load('data')

%% Controle

if isWheelchair
    % Dimensões da cadeira de rodas
%     R = 43.93; % [mm] (Raio das rodas motrizes)
%     b = 35.175; % [mm] (Metade da distância entre as rodas motrizes)
    R = 0.2927; % [m] (Raio das rodas motrizes)
    b = 0.2345; % [m] (Metade da distância entre as rodas motrizes)
else
    % Dimensões do robô
%     R = 24.375; % [mm] (Raio das rodas motrizes)
%     b = 35.125; % [mm] (Metade da distância entre as rodas motrizes)
    R = 0.0975; % [m] (Raio das rodas motrizes)
    b = 0.1405; % [m] (Metade da distância entre as rodas motrizes)
end

% Erro máximo permissível
delta = CellSize/2; % [m]

% Velocidade linear máxima
vmax = 0.1; % [m/s]

% Ganhos proporcionais
% krho = 1; kp = 1.3136; ki = 0.0012; kd = 3.1628; % Funciona bem no p3dx
% krho = 1; kp = 1; ki = 0; kd = 0.1;
% krho = 1; kp = 0.03; ki = 0; kd = 5;
% krho = 1; kp = 0.05; ki = 0; kd = 5;
% krho = 1; kp = 1.5; ki = 0; kd = 0.1;
krho = 1; kp = 0.5; ki = 0; kd = 0.1;

count = 0;
% for i=1:size(target_points,2)
for i=1:length(target_points.x)
    iteration = i
    % Posição objetivo
    PG = [target_points.x(i); target_points.y(i); target_points.th(i)];
    
    if isWheelchair
        % WHEELCHAIR
        
        [err,Position] = vrep.simxGetObjectPosition(clientID,wheelchair,-1,vrep.simx_opmode_buffer);
        [err,Orientation] = vrep.simxGetObjectOrientation(clientID,wheelchair,-1,vrep.simx_opmode_buffer);
        PR = [Position(1)-dist_offset; Position(2); Orientation(3)+angle_offset];
        count = count + 1;
        pose_wheelchair.x(count) = PR(1);
        pose_wheelchair.y(count) = PR(2);
        pose_wheelchair.th(count) = PR(3);
    else
        % P3DX
        
        % Posição do robô
        [err,Position] = vrep.simxGetObjectPosition(clientID,p3dx,-1,vrep.simx_opmode_buffer);
        [err,Orientation] = vrep.simxGetObjectOrientation(clientID,p3dx,-1,vrep.simx_opmode_buffer);
        PR = [Position(1); Position(2); Orientation(3)];
        count = count + 1;
        pose_p3dx.x(count) = PR(1);
        pose_p3dx.y(count) = PR(2);
        pose_p3dx.th(count) = PR(3);
    end
    
    % dx, dy, dth e rho iniciais 
    dx = PG(1) - PR(1);
    dy = PG(2) - PR(2);
    dth = PG(3) - PR(3);
    dth = mod(dth,2*pi);
    if dth > pi
        dth = dth - 2*pi;
    end
    rho = sqrt(dx^2+dy^2);
    
    erro = 0;
    int_erro = 0;
    dif_erro = 0;
    
    while abs(rho) > delta
        if isWheelchair
            % WHEELCHAIR
            
            [err,Position] = vrep.simxGetObjectPosition(clientID,wheelchair,-1,vrep.simx_opmode_buffer);
            [err,Orientation] = vrep.simxGetObjectOrientation(clientID,wheelchair,-1,vrep.simx_opmode_buffer);
            PR = [Position(1)-dist_offset; Position(2); Orientation(3)+angle_offset];
            count = count + 1;
            pose_wheelchair.x(count) = PR(1);
            pose_wheelchair.y(count) = PR(2);
            pose_wheelchair.th(count) = PR(3);
        else
            % P3DX
            
            % Posição do robô
            [err,Position] = vrep.simxGetObjectPosition(clientID,p3dx,-1,vrep.simx_opmode_buffer);
            [err,Orientation] = vrep.simxGetObjectOrientation(clientID,p3dx,-1,vrep.simx_opmode_buffer);
            PR = [Position(1); Position(2); Orientation(3)];
            count = count + 1;
            pose_p3dx.x(count) = PR(1);
            pose_p3dx.y(count) = PR(2);
            pose_p3dx.th(count) = PR(3);
        end
        
        % Atualiza dx, dy e dth
        dx = PG(1) - PR(1);
        dy = PG(2) - PR(2);
        dth = PG(3) - PR(3);
        dth = mod(dth,2*pi);
        if dth > pi
            dth = dth - 2*pi;
        end
        
        % Atualiza e ajusta distância e ângulos
        rho = sqrt(dx^2+dy^2);
        gama = atan2(dy,dx);
        alpha = gama - PR(3);
        alpha = mod(alpha,2*pi);
        if alpha > pi
            alpha = alpha - 2*pi;
        end
        
%         if i < size(target_points,2)
        if i < length(target_points.x)
            v = vmax;
        else
            v = min(krho*rho,vmax);
        end
        
        % Para andar de ré
%         if (alpha > -pi && alpha < -pi/2) || (alpha > pi/2 && alpha <= pi)
%             v = -v;
%             alpha = alpha + pi;         
%         end
        
        dif_erro = alpha - erro;
        erro = alpha;
        int_erro = int_erro + erro;
        w = kp*erro + ki*int_erro + kd*dif_erro;
        w = mod(w,2*pi);
        if w > pi
            w = w - 2*pi;
        end
        w
        phi_r_dot = (v+b*w)/R; % Velocidade da roda direita em rad/s
        phi_l_dot = (v-b*w)/R; % Velocidade da roda esquerda em rad/s
        
        % Faz o robô andar
        if isWheelchair
            % WHEELCHAIR
            vrep.simxSetJointTargetVelocity(clientID,leftMotor,phi_l_dot,vrep.simx_opmode_oneshot);
            vrep.simxSetJointTargetVelocity(clientID,rightMotor,-phi_r_dot,vrep.simx_opmode_oneshot);
        else
            % P3DX
            vrep.simxSetJointTargetVelocity(clientID,leftMotor,phi_l_dot,vrep.simx_opmode_oneshot);
            vrep.simxSetJointTargetVelocity(clientID,rightMotor,phi_r_dot,vrep.simx_opmode_oneshot);
        end
    end
end

% Faz o robô parar
if isWheelchair
    % WHEELCHAIR
    vrep.simxSetJointTargetVelocity(clientID,leftMotor,0,vrep.simx_opmode_oneshot_wait);
    vrep.simxSetJointTargetVelocity(clientID,rightMotor,0,vrep.simx_opmode_oneshot_wait);
else
    % P3DX
    vrep.simxSetJointTargetVelocity(clientID,leftMotor,0,vrep.simx_opmode_oneshot);
    vrep.simxSetJointTargetVelocity(clientID,rightMotor,0,vrep.simx_opmode_oneshot);
end
pause(4)

% Encerra a conexão
vrep.simxFinish(-1);

if isWheelchair
%     save('data_set_1','pose_wheelchair','target_points')
%     save('data_set_2','pose_wheelchair','target_points')
%     save('data_set_3','pose_wheelchair','target_points')
%     save('data_set_4','pose_wheelchair','target_points')
%     save('data_set_5','pose_wheelchair','target_points')
%     save('data_set_6','pose_wheelchair','target_points')
%     save('data_set_7','pose_wheelchair','target_points')
%     save('data_set_8','pose_wheelchair','target_points')
%     save('data_set_9','pose_wheelchair','target_points')
%     save('data_set_10','pose_wheelchair','target_points')
%     save('data_set_11','pose_wheelchair','target_points')
%     save('data_set_12','pose_wheelchair','target_points')
%     save('data_set_13','pose_wheelchair','target_points')
%     save('data_set_14','pose_wheelchair','target_points')
%     save('data_set_15','pose_wheelchair','target_points')
%     save('data_set_16','pose_wheelchair','target_points')
%     save('data_set_17','pose_wheelchair','target_points')
%     save('data_set_18','pose_wheelchair','target_points')
%     save('data_set_19','pose_wheelchair','target_points')
%     save('data_set_20','pose_wheelchair','target_points')
%     save('data_set_21','pose_wheelchair','target_points')
%     save('data_set_22','pose_wheelchair','target_points')
%     save('data_set_23','pose_wheelchair','target_points')
%     save('data_set_24','pose_wheelchair','target_points')
%     save('data_set_25','pose_wheelchair','target_points')
%     save('data_set_26','pose_wheelchair','target_points')
%     save('data_set_27','pose_wheelchair','target_points')
%     save('data_set_28','pose_wheelchair','target_points')
%     save('data_set_29','pose_wheelchair','target_points')
%     save('data_set_30','pose_wheelchair','target_points')
%     save('data_set_31','pose_wheelchair','target_points')
%     save('data_set_32','pose_wheelchair','target_points')
%     save('data_set_33','pose_wheelchair','target_points')
%     save('data_set_34','pose_wheelchair','target_points')
else
%     save('data_set','pose_p3dx','target_points')
end