function Pl = East_Transition_Matrix(MaxCellX,MaxCellY,NumCells)
    
%     Pl = zeros(NumCells,NumCells);
%     for i=1:MaxCellY+1
%         if i == 1 || i == MaxCellY+1
%             Pl(i*(MaxCellX+1),i*(MaxCellX+1)) = 0.9; % Computa a probabilidade das células do canto direito acima e abaixo de se manterem no mesmo estado (não conseguem ir a leste nem a sul ou norte)
%         else
%             Pl(i*(MaxCellX+1),i*(MaxCellX+1)) = 0.8; % Computa a probabilidade das células intermediárias do canto direito de se manterem no mesmo estado (não conseguem ir a leste)
%         end
%         for j=1:MaxCellX+1
%             if i < MaxCellY+1
%                 Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Computa a probabilidade das células intermediárias irem a norte
%                 Pl(i*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Computa a probabilidade das células intermediárias irem a sul
%             end
%             if i == 1 || i == MaxCellY+1
%                 if j < MaxCellX+1
%                     Pl(MaxCellY*(MaxCellX+1)+j,MaxCellY*(MaxCellX+1)+j) = 0.1; % Computa a probabilidade das células da última linha de se manterem no mesmo estado (exceto a do canto direito)
%                     Pl(j,j) = 0.1; % Computa a probabilidade das células da primeira linha de se manterem no mesmo estado (exceto a do canto direito)
%                 end
%             end
%             if j < MaxCellX+1
%                 Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Computa a probabilidade das transições efetivamente irem para o leste
%             end
%         end
%     end
    
    Pl = zeros(NumCells,NumCells);
    for i=1:MaxCellY+1
        for j=1:MaxCellX+1
            % Primeira linha
            if i == 1 && j > 0 && j < 43
                Pl(j,j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 1 && j == 48
                Pl(j,j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 1 && j > 42 && j < 48
                Pl(j,j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if i == 1 && j > 42 && j < 48
                Pl(j,j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if i == 1 && j > 42
                Pl(j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            
            % Segunda linha
            if (i == 2 && j == 1) || (i == 2 && j == 42)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 2 && j == 41
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 2 && j == 48
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 2 && j > 1 && j < 41) || (i == 2 && j == 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 2 && j > 1 && j < 41) || (i == 2 && j > 42 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 2 && j > 1 && j < 42) || (i == 2 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if i == 2 && j > 42
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Terceira linha
            if (i == 3 && j == 1) || (i == 3 && j == 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 3 && j == 42
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 3 && j == 48
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 3 && j == 44
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 3 && j > 1 && j < 42) || (i == 3 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 3 && j > 1 && j < 43) || (i == 3 && j > 44)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 3 && j > 1 && j < 42) || (i == 3 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Quarta linha
            if (i == 4 && j == 1) || (i == 4 && j == 44)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 4 && j == 43
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 4 && j == 48
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 4 && j == 45
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 4 && j > 1 && j < 43) || (i == 4 && j > 44 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 4 && j > 1 && j < 44) || (i == 4 && j > 45)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 4 && j > 1 && j < 43) || (i == 4 && j > 44)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Quinta linha
            if (i == 5 && j == 1) || (i == 5 && j == 45)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 5 && j == 44
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 5 && j == 48
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 5 && j > 20 && j < 26) || (i == 5 && j == 46)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 5 && j > 1 && j < 44) || (i == 5 && j > 45 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 5 && j > 1 && j < 21) || (i == 5 && j > 25 && j < 45) || (i == 5 && j > 46)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 5 && j > 1 && j < 44) || (i == 5 && j > 45)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            % Sexta linha
            if (i == 6 && j == 1) || (i == 6 && j > 20 && j < 26) || (i == 6 && j == 46)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 6 && j == 45
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 6 && j == 20) || (i == 6 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 6 && j == 47
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 6 && j > 1 && j < 20) || (i == 6 && j > 25 && j < 45) || (i == 6 && j == 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 6 && j > 1 && j < 21) || (i == 6 && j > 25 && j < 46) || (i == 6 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 6 && j > 1 && j < 21) || (i == 6 && j > 25 && j < 45) || (i == 6 && j > 46)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Sétima linha
            if (i == 7 && j == 1) || (i == 7 && j == 25) || (i == 7 && j == 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 7 && j == 24) || (i == 7 && j == 46) || (i == 7 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 7 && j > 20 && j < 24
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 7 && j > 1 && j < 24) || (i == 7 && j > 25 && j < 46)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 7 && j > 1 && j < 25) || (i == 7 && j > 25 && j < 47)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 7 && j > 1 && j < 21) || (i == 7 && j > 25 && j < 46) || (i == 7 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Oitava linha
            if (i == 8 && j == 1) || (i == 8 && j == 25) || (i == 8 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 8 && j == 47
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 8 && j == 24
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 8 && j > 1 && j < 24) || (i == 8 && j > 25 && j < 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 8 && j > 1 && j < 25) || (i == 8 && j > 25 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 8 && j > 1 && j < 25) || (i == 8 && j > 25 && j < 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Nona a vigésima segunda linha
            if (i > 8 && i < 23 && j == 1) || (i > 8 && i < 23 && j == 25) || (i > 8 && i < 23 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i > 8 && i < 23 && j == 24) || (i > 8 && i < 23 && j == 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i > 8 && i < 23 && j > 1 && j < 24) || (i > 8 && i < 23 && j > 25 && j < 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i > 8 && i < 23 && j > 1 && j < 25) || (i > 8 && i < 23 && j > 25 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i > 8 && i < 23 && j > 1 && j < 25) || (i > 8 && i < 23 && j > 25 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima terceira linha
            if (i == 23 && j == 1) || (i == 23 && j == 25) || (i == 23 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 23 && j == 24) || (i == 23 && j == 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 23 && j > 1 && j < 12
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 23 && j > 1 && j < 24) || (i == 23 && j > 25 && j < 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 23 && j > 11 && j < 25) || (i == 23 && j > 25 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 23 && j > 1 && j < 25) || (i == 23 && j > 25 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima quarta linha
            if (i == 24 && j > 0 && j < 12) || (i == 24 && j == 25) || (i == 24 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 24 && j == 47
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 24 && j == 24
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 24 && j > 42 && j < 47
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 24 && j > 11 && j < 24) || (i == 24 && j > 25 && j < 47)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 24 && j > 11 && j < 25) || (i == 24 && j > 25 && j < 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 24 && j > 11 && j < 25) || (i == 24 && j > 25 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima quinta linha
            if (i == 25 && j == 11) || (i == 25 && j == 25) || (i == 25 && j > 42)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 25 && j == 10
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 25 && j == 24) || (i == 25 && j == 42)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 25 && j > 0 && j < 10) || (i == 25 && j > 25 && j < 30)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 25 && j > 0 && j < 10) || (i == 25 && j > 11 && j < 24) || (i == 25 && j > 25 && j < 42)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 25 && j > 0 && j < 11) || (i == 25 && j > 11 && j < 25) || (i == 25 && j > 29 && j < 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 25 && j > 11 && j < 25) || (i == 25 && j > 25 && j < 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima sexta linha
            if (i == 26 && j == 11) || (i == 26 && j > 24 && j < 30) || (i == 26 && j == 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 26 && j == 48
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 26 && j == 10) || (i == 26 && j == 24) || (i == 26 && j == 42)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 26 && j > 43 && j < 48
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 26 && j > 0 && j < 10) || (i == 26 && j > 11 && j < 24) || (i == 26 && j > 29 && j < 42) || (i == 26 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 26 && j > 0 && j < 11) || (i == 26 && j > 11 && j < 25) || (i == 26 && j > 29 && j < 43) || (i == 26 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 26 && j > 0 && j < 11) || (i == 26 && j > 11 && j < 25) || (i == 26 && j > 29 && j < 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima sétima linha
            if (i == 27 && j == 11) || (i == 27 && j == 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 27 && j == 10) || (i == 27 && j == 42) || (i == 27 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 27 && j > 24 && j < 30
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 27 && j > 0 && j < 10) || (i == 27 && j > 11 && j < 42) || (i == 27 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 27 && j > 0 && j < 11) || (i == 27 && j > 11 && j < 43) || (i == 27 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 27 && j > 0 && j < 11) || (i == 27 && j > 11 && j < 25) || (i == 27 && j > 29 && j < 43) || (i == 27 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima oitava a trigésima primeira linha
            if (i > 27 && i < 32 && j == 11) || (i > 27 && i < 32 && j == 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i > 27 && i < 32 && j == 10) || (i > 27 && i < 32 && j == 42) || (i > 27 && i < 32 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i > 27 && i < 32 && j > 0 && j < 10) || (i > 27 && i < 32 && j > 11 && j < 42) || (i > 27 && i < 32 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i > 27 && i < 32 && j > 0 && j < 11) || (i > 27 && i < 32 && j > 11 && j < 43) || (i > 27 && i < 32 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i > 27 && i < 32 && j > 0 && j < 11) || (i > 27 && i < 32 && j > 11 && j < 43) || (i > 27 && i < 32 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Trigésima segunda linha
            if (i == 32 && j == 11) || (i == 32 && j == 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 32 && j == 42
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 32 && j == 10) || (i == 32 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 32 && j > 11 && j < 42
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 32 && j > 0 && j < 10) || (i == 32 && j > 11 && j < 42) || (i == 32 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 32 && j > 0 && j < 11) || (i == 32 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 32 && j > 0 && j < 11) || (i == 32 && j > 11 && j < 43) || (i == 32 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Trigésima terceira linha
            if (i == 33 && j > 10 && j < 44)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 33 && j == 10) || (i == 33 && j == 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 33 && j > 0 && j < 10) || (i == 33 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 33 && j > 0 && j < 10) || (i == 33 && j > 43 && j < 48)
                Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if (i == 33 && j > 0 && j < 11) || (i == 33 && j > 43)
                Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
        end
    end
    
%     Pl = zeros(NumCells,NumCells);
%     for i=1:MaxCellY+1
%         for j=1:MaxCellX+1
%             if ~isempty(find(ocu == (i-1)*(MaxCellX+1)+j))
%                 Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula se esta é uma célula ocupada
%             else
%                 if j == MaxCellX+1 % Última coluna
%                     Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.8; % Probabilidade de se manter na mesma célula
%                 else % Outras colunas
%                     Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.8; % Probabilidade de ir para leste
%                 end
%                 
%                 if i == 1 % Primeira linha
%                     Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma célula
%                     Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o norte
%                 elseif i == MaxCellY+1 % Última linha
%                     Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Pl((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma célula
%                     Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o sul
%                 else % Outras linhas
%                     Pl((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o norte
%                     Pl((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o sul
%                 end
%             end
%         end
%     end
    
end

