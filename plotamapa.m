%
%   Copyright (C) 2014 Eleri Cardozo
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

% plota mapa de celulas
% retorna celulas ocupadas

function result = plotamapa(mapa, CellSize, MaxCellX, MaxCellY)
    
    figure(1);
    hold on;
    ocupadas = [];
    
    for k=1:size(mapa, 1)
        if mapa(k, 5) == 1 && mapa(k, 6) == 0   % linha vertical
            i = ceil(mapa(k, 1)/CellSize) + 1;
            if mapa(k, 2) < mapa(k, 4)
                y_inicio = ceil(mapa(k, 2)/CellSize) + 1;
                y_fim = ceil(mapa(k,4)/CellSize) + 1;
            else
                y_fim = ceil(mapa(k, 2)/CellSize) + 1;
                y_inicio = ceil(mapa(k,4)/CellSize) + 1;
            end
            for j = y_inicio:y_fim
                ocupadas = [ocupadas; i j];
            end
        end
        if mapa(k, 5) == 0 && mapa(k, 6) == 1   % linha horizontal
            j = ceil(mapa(k, 2)/CellSize) + 1;
            if mapa(k, 1) < mapa(k, 3)
                x_inicio = ceil(mapa(k, 1)/CellSize) + 1;
                x_fim = ceil(mapa(k,3)/CellSize) + 1;
            else
                x_fim = ceil(mapa(k, 1)/CellSize) + 1;
                x_inicio = ceil(mapa(k,3)/CellSize) + 1;
            end
            for i = x_inicio:x_fim
                ocupadas = [ocupadas; i j];
            end
        end
        if mapa(k, 5) ~= 0 && mapa(k, 6) ~= 0   % linha generica
            if mapa(k, 1) < mapa(k, 3)
                x_inicio = ceil(mapa(k, 1)/CellSize) + 1;
                x_fim = ceil(mapa(k,3)/CellSize) + 1;
            else
                x_fim = ceil(mapa(k, 1)/CellSize) + 1;
                x_inicio = ceil(mapa(k,3)/CellSize) + 1;
            end
            for i = x_inicio:x_fim
                j = ceil((mapa(k,7)/CellSize - mapa(k, 5)*i)/mapa(k,6));
                ocupadas = [ocupadas; i j];
            end
        end
    end

    % plota grade
    figure(1);
    hold on
    cx = [];
    cy = [];
    for i=1:MaxCellX+1
        cx = [cx i i i+1];
        cy = [cy 1 MaxCellY+2 MaxCellY+2];
    end
    plot(cx, cy, 'k' , 'LineWidth' , 1);
    cx = [];
    cy = [];
    for j=1:MaxCellY+1
        cx = [cx 1 MaxCellX+2 MaxCellX+2];
        cy = [cy j j j+1];
    end
    plot(cx, cy, 'k' , 'LineWidth' , 1);
    
    % plota celulas ocupadas
    for k=1:size(ocupadas, 1)
        i = ocupadas(k, 1);
        j = ocupadas(k, 2);
        cx = [i i i+1 i+1 i];
        cy = [j j+1 j+1 j j];
        plot(cx, cy, 'r' , 'LineWidth' , 3);
    end
    
    result = ocupadas;
    
end