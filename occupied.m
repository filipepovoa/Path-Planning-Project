clc; clear all; close all;

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