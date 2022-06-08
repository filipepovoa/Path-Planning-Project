function Pn = North_Transition_Matrix(MaxCellX,MaxCellY,NumCells)
    
%     Pn = zeros(NumCells,NumCells);
%     for i=1:MaxCellY
%         Pn((i-1)*(MaxCellX+1)+1,(i-1)*(MaxCellX+1)+1) = 0.1; % Computa a probabilidade das transi��es se manterem no mesmo estado para c�lulas do canto esquerdo (possuem probabilidade de ir ao oeste, mas n�o conseguem)
%         Pn(i*(MaxCellX+1),i*(MaxCellX+1)) = 0.1; % Computa a probabilidade das transi��es de se manterem no mesmo estado para c�lulas do canto direito (possuem probabilidade de ir ao leste, mas n�o conseguem)
%         for j=1:MaxCellX+1
%             Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Computa a probabibilidade das transi��es efetivamente irem para o norte
%             if j > 1
%                 Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Computa a probabilidade das transi��es ocorrem com movimento a oeste (exceto para a �ltima linha)
%             end
%             if j < MaxCellX+1
%                 Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Computa a probabilidade das transi��es ocorrerem com movimenta��o a leste (exceto para a �tima linha)
%             end
%             if i == MaxCellY % Entra aqui somente na �ltima itera��o em i
%                 if j > 1
%                     Pn(MaxCellY*(MaxCellX+1)+j,MaxCellY*(MaxCellX+1)+j-1) = 0.1; % Computa a probabilidade das transi��es ocorrem com movimento a oeste (na �ltima linha)
%                 end
%                 if j < MaxCellX+1
%                     Pn(MaxCellY*(MaxCellX+1)+j,MaxCellY*(MaxCellX+1)+j+1) = 0.1; % Computa a probabilidade das transi��es ocorrerem com movimenta��o a leste (na �tima linha)
%                 end
%                 if j == 1 || j == MaxCellX+1
%                     Pn(MaxCellY*(MaxCellX+1)+j,MaxCellY*(MaxCellX+1)+j) = 0.9; % Computa a probabilidade da �ltima c�lula acima no canto esquerdo e direito de se manter no mesmo estado (n�o conseguem ir a norte nem a oeste ou leste)
%                 else
%                     Pn(MaxCellY*(MaxCellX+1)+j,MaxCellY*(MaxCellX+1)+j) = 0.8; % Computa a probabilidade das �ltimas c�lulas intermedi�rias de se manterem no mesmo estado (n�o conseguem ir a norte)
%                 end
%             end
%         end
%     end
    
    Pn = zeros(NumCells,NumCells);
    for i=1:MaxCellY+1
        for j=1:MaxCellX+1
            % Primeira linha
            if i == 1 && j < 43
                Pn(j,j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 1 && j == 43
                Pn(j,j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 1 && j == 48
                Pn(j,j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 1 && j > 42
                Pn(j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if i == 1 && j > 42 && j < 48
                Pn(j,j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if i == 1 && j > 43
                Pn(j,j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Segunda linha
            if (i == 2 && j == 1) || (i == 2 && j == 42)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 2 && j == 2) || (i == 2 && j == 41) || (i == 2 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 2 && j == 43
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 2 && j > 1 && j < 42) || (i == 2 && j > 43)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 2 && j > 1 && j < 41) || (i == 2 && j > 42 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 2 && j > 2 && j < 42) || (i == 2 && j > 43)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Terceira linha
            if (i == 3 && j == 1) || (i == 3 && j == 43)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 3 && j == 2) || (i == 3 && j == 42) || (i == 3 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 3 && j == 44
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 3 && j > 1 && j < 43) || (i == 3 && j > 44)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 3 && j > 1 && j < 42) || (i == 3 && j > 43 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 3 && j > 2 && j < 43) || (i == 3 && j > 44)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Quarta linha
            if (i == 4 && j == 1) || (i == 4 && j == 44)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 4 && j == 2) || (i == 4 && j == 43) || (i == 4 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 4 && j == 45
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 4 && j > 1 && j < 44) || (i == 4 && j > 45)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 4 && j > 1 && j < 43) || (i == 4 && j > 44 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 4 && j > 2 && j < 44) || (i == 4 && j > 45)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Quinta linha
            if (i == 5 && j == 1) || (i == 5 && j == 45)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 5 && j > 20 && j < 26)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 5 && j == 2) || (i == 5 && j == 44) || (i == 5 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 5 && j == 46
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 5 && j > 1 && j < 21) || (i == 5 && j > 25 && j < 45) || (i == 5 && j > 46)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 5 && j > 1 && j < 44) || (i == 5 && j > 45 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 5 && j > 2 && j < 45) || (i == 5 && j > 46)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Sexta linha
            if (i == 6 && j == 1) || (i == 6 && j > 20 && j < 26) || (i == 6 && j == 46)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 6 && j == 2) || (i == 6 && j == 20) || (i == 6 && j == 26) || (i == 6 && j == 45) || (i == 6 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 6 && j == 47
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 6 && j > 1 && j < 21) || (i == 6 && j > 25 && j < 46) || (i == 6 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 6 && j > 1 && j < 20) || (i == 6 && j > 25 && j < 45) || (i == 6 && j == 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 6 && j > 2 && j < 21) || (i == 6 && j > 26 && j < 46) || (i == 6 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % S�tima linha
            if (i == 7 && j == 1) || (i == 7 && j == 25) || (i == 7 && j > 46)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 7 && j == 2) || (i == 7 && j == 24) || (i == 7 && j == 26) || (i == 7 && j == 46)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 7 && j > 1 && j < 25) || (i == 7 && j > 25 && j < 47)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 7 && j > 1 && j < 24) || (i == 7 && j > 25 && j < 46)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 7 && j > 2 && j < 25) || (i == 7 && j > 26 && j < 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Oitava a vig�sima segunda linha
            if (i > 7 && i < 23 && j == 1) || (i > 7 && i < 23 && j == 25) || (i > 7 && i < 23 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 7 && i < 23 && j == 2) || (i > 7 && i < 23 && j == 24) || (i > 7 && i < 23 && j == 26) || (i > 7 && i < 23 && j == 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 7 && i < 23 && j > 1 && j < 25) || (i > 7 && i < 23 && j > 25 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i > 7 && i < 23 && j > 1 && j < 24) || (i > 7 && i < 23 && j > 25 && j < 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i > 7 && i < 23 && j > 2 && j < 25) || (i > 7 && i < 23 && j > 26 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima terceira linha
            if (i == 23 && j == 1) || (i == 23 && j == 25) || (i == 23 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 23 && j == 2
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 23 && j > 2 && j < 12
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 23 && j == 24) || (i == 23 && j == 26) || (i == 23 && j == 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 23 && j > 11 && j < 25) || (i == 23 && j > 25 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 23 && j > 1 && j < 24) || (i == 23 && j > 25 && j < 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 23 && j > 2 && j < 25) || (i == 23 && j > 26 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima quarta linha
            if (i == 24 && j > 0 && j < 12) || (i == 24 && j == 25) || (i == 24 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 24 && j == 47
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 24 && j > 42 && j < 47
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 24 && j == 12) || (i == 24 && j == 24) || (i == 24 && j == 26)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 24 && j > 11 && j < 25) || (i == 24 && j > 25 && j < 43)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 24 && j > 11 && j < 24) || (i == 24 && j > 25 && j < 47)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 24 && j > 12 && j < 25) || (i == 24 && j > 26 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima quinta linha
            if (i == 25 && j == 11) || (i == 25 && j == 25) || (i == 25 && j > 42)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 25 && j == 26
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 25 && j > 26 && j < 30
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 25 && j == 1) || (i == 25 && j == 10) || (i == 25 && j == 12) || (i == 25 && j == 24) || (i == 25 && j == 42)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 25 && j > 0 && j < 11) || (i == 25 && j > 11 && j < 25) || (i == 25 && j > 29 && j < 43)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 25 && j > 0 && j < 10) || (i == 25 && j > 11 && j < 24) || (i == 25 && j > 25 && j < 42)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 25 && j > 1 && j < 11) || (i == 25 && j > 12 && j < 25) || (i == 25 && j > 26 && j < 43)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima sexta linha
            if (i == 26 && j == 11) || (i == 26 && j > 24 && j < 30) || (i == 26 && j == 43)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 26 && j == 1) || (i == 26 && j == 10) || (i == 26 && j == 12) || (i == 26 && j == 24) || (i == 26 && j == 30) || (i == 26 && j == 42) || (i == 26 && j == 44) || (i == 26 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 26 && j > 0 && j < 11) || (i == 26 && j > 11 && j < 25) || (i == 26 && j > 29 && j < 43) || (i == 26 && j > 43)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 26 && j > 0 && j < 10) || (i == 26 && j > 11 && j < 24) || (i == 26 && j > 29 && j < 42) || (i == 26 && j > 43 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 26 && j > 1 && j < 11) || (i == 26 && j > 12 && j < 25) || (i == 26 && j > 30 && j < 43) || (i == 26 && j > 44)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima s�tima a trig�sima primeira linha
            if (i > 26 && i < 32 && j == 11) || (i > 26 && i < 32 && j == 43)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 26 && i < 32 && j == 1) || (i > 26 && i < 32 && j == 10) || (i > 26 && j < 32 && j == 12) || (i > 26 && i < 32 && j == 42) || (i > 26 && i < 32 && j == 44) || (i > 26 && i < 32 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 26 && i < 32 && j > 0 && j < 11) || (i > 26 && i < 32 && j > 11 && j < 43) || (i > 26 && i < 32 && j > 43)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i > 26 && i < 32 && j > 0 && j < 10) || (i > 26 && i < 32 && j > 11 && j < 42) || (i > 26 && i < 32 && j > 43 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i > 26 && i < 32 && j > 1 && j < 11) || (i > 26 && i < 32 && j > 12 && j < 43) || (i > 26 && i < 32 && j > 44)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Trig�sima segunda linha
            if (i == 32 && j == 11) || (i == 32 && j == 43)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 32 && j == 12) || (i == 32 && j == 42)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 32 && j > 12 && j < 42
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 32 && j == 1) || (i == 32 && j == 10) || (i == 32 && j == 44) || (i == 32 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 32 && j > 0 && j < 11) || (i == 32 && j > 43)
                Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao norte
            end
            if (i == 32 && j > 0 && j < 10) || (i == 32 && j > 11 && j < 42) || (i == 32 && j > 43 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 32 && j > 1 && j < 11) || (i == 32 && j > 12 && j < 43) || (i == 32 && j > 44)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Trig�sima terceira linha
            if i == 33 && j > 10 && j < 44
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 33 && j == 1) || (i == 33 && j == 10) || (i == 33 && j == 44) || (i == 33 && j == 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 33 && j > 1 && j < 10) || (i == 33 && j > 44 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 33 && j > 0 && j < 10) || (i == 33 && j > 43 && j < 48)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 33 && j > 1 && j < 11) || (i == 33 && j > 44)
                Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
        end
    end
    
%     Pn = zeros(NumCells,NumCells);
%     for i=1:MaxCellY+1
%         for j=1:MaxCellX+1
%             if ~isempty(find(ocu == (i-1)*(MaxCellX+1)+j))
%                 Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula se esta � uma c�lula ocupada
%             else
%                 if i == MaxCellY+1 % �ltima linha
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.8; % Probabilidade de se manter na mesma c�lula
%                 else % Outras linhas
%                     Pn((i-1)*(MaxCellX+1)+j,i*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para o norte
%                 end
%                 
%                 if j == 1  % Primeira coluna
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma c�lula
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para leste
%                 elseif j == MaxCellX+1 % �ltima coluna
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma c�lula
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para oeste
%                 else % Outras colunas
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para leste
%                     Pn((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para oeste
%                 end
%             end
%         end
%     end
    
end

