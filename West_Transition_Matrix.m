function Po = West_Transition_Matrix(MaxCellX,MaxCellY,NumCells)
    
%     Po = zeros(NumCells,NumCells);
%     for i=1:MaxCellY+1
%         if i == 1 || i == MaxCellY+1
%             Po((i-1)*(MaxCellX+1)+1,(i-1)*(MaxCellX+1)+1) = 0.9; % Computa a probabilidade das células do canto esquerdo acima e abaixo de se manterem no mesmo estado (não conseguem ir a oeste nem a sul ou norte)
%         else
%             Po((i-1)*(MaxCellX+1)+1,(i-1)*(MaxCellX+1)+1) = 0.8; % Computa a probabilidade das células intermediárias do canto esquerdo de se manterem no mesmo estado (não conseguem ir a oeste)
%         end
%         for j=1:MaxCellX+1
%             if i < MaxCellY+1
%                 Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Computa a probabilidade das células intermediárias irem a norte
%                 Po(i*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Computa a probabilidade das células intermediárias irem a sul
%             end
%             if i == 1 || i == MaxCellY+1
%                 if j > 1
%                     Po(MaxCellY*(MaxCellX+1)+j,MaxCellY*(MaxCellX+1)+j) = 0.1; % Computa a probabilidade das células da última linha de se manterem no mesmo estado (exceto a do canto esquerdo)
%                     Po(j,j) = 0.1; % Computa a probabilidade das células da primeira linha de se manterem no mesmo estado (exceto a do canto esquerdo)
%                 end
%             end
%             if j > 1
%                 Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Computa a probabilidade das transições efetivamente irem para o oeste
%             end
%         end
%     end
    
    Po = zeros(NumCells,NumCells);
    for i=1:MaxCellY+1
        for j=1:MaxCellX+1
            % Primeira linha
            if i == 1 && j > 0 && j < 43
                Po(j,j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 1 && j == 43
                Po(j,j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 1 && j > 43
                Po(j,j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if i == 1 && j > 43
                Po(j,j-1) = 0.8; % Probabilidade de ir para a célula a leste
            end
            if i == 1 && j > 42
                Po(j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            
            % Segunda linha
            if (i == 2 && j == 1) || (i == 2 && j == 42)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 2 && j == 2) || (i == 2 && j == 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 2 && j > 2 && j < 42
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 2 && j > 2 && j < 42) || (i == 2 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 2 && j > 1 && j < 42) || (i == 2 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if i == 2 && j > 42
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Terceira linha
            if (i == 3 && j == 1) || (i == 3 && j == 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 3 && j == 44
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 3 && j == 2
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 3 && j == 42
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 3 && j > 2 && j < 43) || (i == 3 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 3 && j > 1 && j < 43) || (i == 3 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 3 && j > 1 && j < 42) || (i == 3 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Quarta linha
            if (i == 4 && j == 1) || (i == 4 && j == 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 4 && j == 45
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 4 && j == 2
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 4 && j == 43
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 4 && j > 2 && j < 44) || (i == 4 && j > 45)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 4 && j > 1 && j < 44) || (i == 4 && j > 45)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 4 && j > 1 && j < 43) || (i == 4 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Quinta linha
            if (i == 5 && j == 1) || (i == 5 && j == 45)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 5 && j == 46
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 5 && j == 2
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 5 && j > 20 && j < 26) || (i == 5 && j == 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 5 && j > 2 && j < 45) || (i == 5 && j > 46)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 5 && j > 1 && j < 21) || (i == 5 && j > 25 && j < 45) || (i == 5 && j > 46)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 5 && j > 1 && j < 44) || (i == 5 && j > 45)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Sexta linha
            if (i == 6 && j == 1) || (i == 6 && j > 20 && j < 26) || (i == 6 && j == 46)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 6 && j == 47
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 6 && j == 2) || (i == 6 && j == 26)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 6 && j == 45
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 6 && j > 2 && j < 21) || (i == 6 && j > 26 && j < 46) || (i == 6 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 6 && j > 1 && j < 21) || (i == 6 && j > 25 && j < 46) || (i == 6 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 6 && j > 1 && j < 21) || (i == 6 && j > 25 && j < 45) || (i == 6 && j > 46)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Sétima linha
            if (i == 7 && j == 1) || (i == 7 && j == 25) || (i == 7 && j == 47)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 7 && j == 48
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 7 && j == 2) || (i == 7 && j == 26)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 7 && j > 20 && j < 25) || (i == 7 && j == 46)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 7 && j > 2 && j < 25) || (i == 7 && j > 26 && j < 47)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 7 && j > 1 && j < 25) || (i == 7 && j > 25 && j < 47)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 7 && j > 1 && j < 21) || (i == 7 && j > 25 && j < 46) || (i == 7 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Oitava linha
            if (i == 8 && j == 1) || (i == 8 && j == 25) || (i == 8 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 8 && j == 2) || (i == 8 && j == 26)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 8 && j == 47
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 8 && j > 2 && j < 25) || (i == 8 && j > 26 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 8 && j > 1 && j < 25) || (i == 8 && j > 25 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 8 && j > 1 && j < 25) || (i == 8 && j > 25 && j < 47)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Nona a vigésima segunda linha
            if (i > 8 && i < 23 && j == 1) || (i > 8 && i < 23 && j == 25) || (i > 8 && i < 23 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i > 8 && i < 23 && j == 2) || (i > 8 && i < 23 && j == 26)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i > 8 && i < 23 && j > 2 && j < 25) || (i > 8 && i < 23 && j > 26 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i > 8 && i < 23 && j > 1 && j < 25) || (i > 8 && i < 23 && j > 25 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i > 8 && i < 23 && j > 1 && j < 25) || (i > 8 && i < 23 && j > 25 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima terceira linha
            if (i == 23 && j == 1) || (i == 23 && j == 25) || (i == 23 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 23 && j == 2
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 23 && j == 26
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 23 && j > 2 && j < 12
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 23 && j > 2 && j < 25) || (i == 23 && j > 26 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 23 && j > 11 && j < 25) || (i == 23 && j > 25 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 23 && j > 1 && j < 25) || (i == 23 && j > 25 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima quarta linha
            if (i == 24 && j > 0 && j < 12) || (i == 24 && j == 25) || (i == 24 && j == 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 24 && j == 12) || (i == 24 && j == 26)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 24 && j > 42 && j < 48
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 24 && j > 12 && j < 25) || (i == 24 && j > 26 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 24 && j > 11 && j < 25) || (i == 24 && j > 25 && j < 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 24 && j > 11 && j < 25) || (i == 24 && j > 25 && j < 48)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima quinta linha
            if (i == 25 && j == 11) || (i == 25 && j == 25) || (i == 25 && j > 42)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 25 && j == 1) || (i == 25 && j == 26)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if i == 25 && j == 12
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i == 25 && j > 1 && j < 11) || (i == 25 && j > 26 && j < 30)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 25 && j > 1 && j < 11) || (i == 25 && j > 12 && j < 25) || (i == 25 && j > 26 && j < 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 25 && j > 0 && j < 11) || (i == 25 && j > 11 && j < 25) || (i == 25 && j > 29 && j < 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 25 && j > 11 && j < 25) || (i == 25 && j > 25 && j < 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima sexta linha
            if (i == 26 && j == 11) || (i == 26 && j > 24 && j < 30) || (i == 26 && j == 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 26 && j == 44
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 26 && j == 1) || (i == 26 && j == 12) || (i == 26 && j == 30)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 26 && j > 44
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 26 && j > 1 && j < 11) || (i == 26 && j > 12 && j < 25) || (i == 26 && j > 30 && j < 43) || (i == 26 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 26 && j > 0 && j < 11) || (i == 26 && j > 11 && j < 25) || (i == 26 && j > 29 && j < 43) || (i == 26 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 26 && j > 0 && j < 11) || (i == 26 && j > 11 && j < 25) || (i == 26 && j > 29 && j < 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima sétima linha
            if (i == 27 && j == 11) || (i == 27 && j == 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 27 && j == 1) || (i == 27 && j == 12) || (i == 27 && j == 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 27 && j > 24 && j < 30
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 27 && j > 1 && j < 11) || (i == 27 && j > 12 && j < 43) || (i == 27 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 27 && j > 0 && j < 11) || (i == 27 && j > 11 && j < 43) || (i == 27 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 27 && j > 0 && j < 11) || (i == 27 && j > 11 && j < 25) || (i == 27 && j > 29 && j < 43) || (i == 27 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Vigésima oitava a trigésima primeira linha
            if (i > 27 && i < 32 && j == 11) || (i > 27 && i < 32 && j == 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i > 27 && i < 32 && j == 1) || (i > 27 && i < 32 && j == 12) || (i > 27 && i < 32 && j == 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if (i > 27 && i < 32 && j > 1 && j < 11) || (i > 27 && i < 32 && j > 12 && j < 43) || (i > 27 && i < 32 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i > 27 && i < 32 && j > 0 && j < 11) || (i > 27 && i < 32 && j > 11 && j < 43) || (i > 27 && i < 32 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i > 27 && i < 32 && j > 0 && j < 11) || (i > 27 && i < 32 && j > 11 && j < 43) || (i > 27 && i < 32 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Trigésima segunda linha
            if (i == 32 && j == 11) || (i == 32 && j == 43)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if i == 32 && j == 12
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 32 && j == 1) || (i == 32 && j == 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma célula
            end
            if i == 32 && j > 12 && j < 43
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 32 && j > 1 && j < 11) || (i == 32 && j > 12 && j < 43) || (i == 32 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 32 && j > 0 && j < 11) || (i == 32 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao norte
            end
            if (i == 32 && j > 0 && j < 11) || (i == 32 && j > 11 && j < 43) || (i == 32 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
            
            % Trigésima terceira linha
            if i == 33 && j > 10 && j < 44
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula
            end
            if (i == 33 && j == 1) || (i == 33 && j == 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma célula
            end
            if (i == 33 && j > 1 && j < 11) || (i == 33 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma célula
            end
            if (i == 33 && j > 1 && j < 11) || (i == 33 && j > 44)
                Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para a célula a oeste
            end
            if (i == 33 && j > 0 && j < 11) || (i == 33 && j > 43)
                Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para a célula ao sul
            end
        end
    end
    
%     Po = zeros(NumCells,NumCells);
%     for i=1:MaxCellY+1
%         for j=1:MaxCellX+1
%             if ~isempty(find(ocu == (i-1)*(MaxCellX+1)+j))
%                 Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma célula se esta é uma célula ocupada
%             else
%                 if j == 1 % Primeira coluna
%                     Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.8; % Probabilidade de se manter na mesma célula
%                 else % Outras colunas
%                     Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.8; % Probabilidade de ir para oeste
%                 end
%                 
%                 if i == 1 % Primeira linha
%                     Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma célula
%                     Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o norte
%                 elseif i == MaxCellY+1 % Última linha
%                     Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Po((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma célula
%                     Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o sul
%                 else % Outras linhas
%                     Po((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o norte
%                     Po((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.1; % Probabilidade de ir para o sul
%                 end
%             end
%         end
%     end
    
end

