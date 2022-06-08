function Ps = South_Transition_Matrix(MaxCellX,MaxCellY,NumCells)
    
%     Ps = zeros(NumCells,NumCells);
%     for i=1:MaxCellY
%         Ps(i*(MaxCellX+1)+1,i*(MaxCellX+1)+1) = 0.1; % Computa a probabilidade das transi��es se manterem no mesmo estado para c�lulas do canto esquerdo (possuem probabilidade de ir ao oeste, mas n�o conseguem)
%         Ps((i+1)*(MaxCellX+1),(i+1)*(MaxCellX+1)) = 0.1; % Computa a probabilidade das transi��es de se manterem no mesmo estado para c�lulas do canto direito (possuem probabilidade de ir ao leste, mas n�o conseguem)
%         for j=1:MaxCellX+1
%             Ps(i*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Computa a probabibilidade das transi��es efetivamente irem para o sul
%             if j > 1
%                 Ps(i*(MaxCellX+1)+j,i*(MaxCellX+1)+j-1) = 0.1; % Computa a probabilidade das transi��es ocorrem com movimento a oeste (exceto para a primeira linha)
%             end
%             if j < MaxCellX+1
%                 Ps(i*(MaxCellX+1)+j,i*(MaxCellX+1)+j+1) = 0.1; % Computa a probabilidade das transi��es ocorrerem com movimenta��o a leste (exceto para a primeira linha)
%             end
%             if i == 1 % Entra aqui somente na primeira itera��o em i
%                 if j > 1
%                     Ps(j,j-1) = 0.1; % Computa a probabilidade das transi��es ocorrem com movimento a oeste (na primeira linha)
%                 end
%                 if j < MaxCellX+1
%                     Ps(j,j+1) = 0.1; % Computa a probabilidade das transi��es ocorrerem com movimenta��o a leste (na primeira linha)
%                 end
%                 if j == 1 || j == MaxCellX+1
%                     Ps(j,j) = 0.9; % Computa a probabilidade da primeira c�lula abaixo no canto esquerdo e direito de se manter no mesmo estado (n�o conseguem ir a sul nem a oeste ou leste)
%                 else
%                     Ps(j,j) = 0.8; % Computa a probabilidade das primeiras c�lulas intermedi�rias de se manterem no mesmo estado (n�o conseguem ir a sul)
%                 end
%             end
%         end
%     end
    
    Ps = zeros(NumCells,NumCells);
    for i=1:MaxCellY+1
        for j=1:MaxCellX+1
            % Primeira linha
            if i == 1 && j > 0 && j < 43
                Ps(j,j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 1 && j == 43) || (i == 1 && j == 48)
                Ps(j,j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 1 && j > 43 && j < 48
                Ps(j,j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if i == 1 && j > 42 && j < 48
                Ps(j,j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if i == 1 && j > 43
                Ps(j,j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Segunda linha
            if (i == 2 && j == 1) || (i == 2 && j == 42)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 2 && j == 2) || (i == 2 && j == 41)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 2 && j > 2 && j < 41
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 2 && j == 43) || (i == 2 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 2 && j > 42
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 2 && j > 1 && j < 41) || (i == 2 && j > 42 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 2 && j > 2 && j < 42) || (i == 2 && j > 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Terceira linha
            if (i == 3 && j == 1) || (i == 3 && j == 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 3 && j == 42
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 3 && j == 2) || (i == 3 && j == 44) || (i == 3 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 3 && j > 1 && j < 42) || (i == 3 && j > 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 3 && j > 1 && j < 42) || (i == 3 && j > 43 && j < 48)
               Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 3 && j > 2 && j < 43) || (i == 3 && j > 44)
               Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Quarta linha
            if (i == 4 && j == 1) || (i == 4 && j == 44)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 4 && j == 43
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 4 && j == 2) || (i == 4 && j == 45) || (i == 4 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 4 && j > 1 && j < 43) || (i == 4 && j > 44)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 4 && j > 1 && j < 43) || (i == 4 && j > 44 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 4 && j > 2 && j < 44) || (i == 4 && j > 45)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Quinta linha
            if (i == 5 && j == 1) || (i == 5 && j == 45)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 5 && j == 44
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 5 && j == 2) || (i == 5 && j == 46) || (i == 5 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 5 && j > 1 && j < 44) || (i == 5 && j > 45)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 5 && j > 1 && j < 44) || (i == 5 && j > 45 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 5 && j > 2 && j < 45) || (i == 5 && j > 46)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Sexta linha
            if (i == 6 && j == 1) || (i == 6 && j > 20 && j < 26) || (i == 6 && j == 46)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 6 && j == 45
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 6 && j == 2) || (i == 6 && j == 20) || (i == 6 && j == 26) || (i == 6 && j > 46)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 6 && j > 1 && j < 21) || (i == 6 && j > 25 && j < 45) || (i == 6 && j > 46)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 6 && j > 1 && j < 20) || (i == 6 && j > 25 && j < 45) || (i == 6 && j == 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 6 && j > 2 && j < 21) || (i == 6 && j > 26 && j < 46) || (i == 6 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % S�tima linha
            if (i == 7 && j == 1) || (i == 7 && j == 25) || (i == 7 && j == 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 7 && j == 24) || (i == 7 && j == 46)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 7 && j > 20 && j < 24
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if i == 7 && j == 48
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.2; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 7 && j == 2) || (i == 7 && j == 26)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 7 && j > 1 && j < 21) || (i == 7 && j > 25 && j < 46) || (i == 7 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 7 && j > 1 && j < 24) || (i == 7 && j > 25 && j < 46)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 7 && j > 2 && j < 25) || (i == 7 && j > 26 && j < 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Oitava linha
            if (i == 8 && j == 1) || (i == 8 && j == 25) || (i == 8 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 8 && j == 47
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 8 && j == 2) || (i == 8 && j == 24) || (i == 8 && j == 26)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 8 && j > 1 && j < 25) || (i == 8 && j > 25 && j < 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 8 && j > 1 && j < 24) || (i == 8 && j > 25 && j < 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 8 && j > 2 && j < 25) || (i == 8 && j > 26 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Nona a vig�sima terceira linha
            if (i > 8 && i < 24 && j == 1) || (i > 8 && i < 24 && j == 25) || (i > 8 && i < 24 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 8 && i < 24 && j == 2) || (i > 8 && i < 24 && j == 24) || (i > 8 && i < 24 && j == 26) || (i > 8 && i < 24 && j == 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 8 && i < 24 && j > 1 && j < 25) || (i > 8 && i < 24 && j > 25 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i > 8 && i < 24 && j > 1 && j < 24) || (i > 8 && i < 24 && j > 25 && j < 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i > 8 && i < 24 && j > 2 && j < 25) || (i > 8 && i < 24 && j > 26 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima quarta linha
            if (i == 24 && j > 0 && j < 12) || (i == 24 && j == 25) || (i == 24 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 24 && j == 12) || (i == 24 && j == 24) || (i == 24 && j == 26) || (i == 24 && j == 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 24 && j > 11 && j < 25) || (i == 24 && j > 25 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 24 && j > 11 && j < 24) || (i == 24 && j > 25 && j < 47)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 24 && j > 12 && j < 25) || (i == 24 && j > 26 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima quinta linha
            if (i == 25 && j == 11) || (i == 25 && j == 25) || (i == 25 && j > 42)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 25 && j == 1) || (i == 25 && j == 10)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 25 && j > 1 && j < 10
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 25 && j == 12) || (i == 25 && j == 24) || (i == 25 && j == 26) || (i == 25 && j == 42)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 25 && j > 11 && j < 25) || (i == 25 && j > 25 && j < 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 25 && j > 0 && j < 10) || (i == 25 && j > 11 && j < 24) || (i == 25 && j > 25 && j < 42)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 25 && j > 1 && j < 11) || (i == 25 && j > 12 && j < 25) || (i == 25 && j > 26 && j < 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima sexta linha
            if (i == 26 && j == 11) || (i == 26 && j > 24 && j < 30) || (i == 26 && j == 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 26 && j == 44) || (i == 26 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.9; % Probabilidade de se manter na mesma c�lula
            end
            if i == 26 && j > 44 && j < 48
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 26 && j == 1) || (i == 26 && j == 10) || (i == 26 && j == 12) || (i == 26 && j == 24) || (i == 26 && j == 30) || (i == 26 && j == 42)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 26 && j > 0 && j < 11) || (i == 26 && j > 11 && j < 25) || (i == 26 && j > 29 && j < 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 26 && j > 0 && j < 10) || (i == 26 && j > 11 && j < 24) || (i == 26 && j > 29 && j < 42) || (i == 26 && j > 43 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 26 && j > 1 && j < 11) || (i == 26 && j > 12 && j < 25) || (i == 26 && j > 30 && j < 43) || (i == 26 && j > 44)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima s�tima linha
            if (i == 27 && j == 11) || (i == 27 && j == 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if i == 27 && j > 24 && j < 30
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.8; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 27 && j == 1) || (i == 27 && j == 10) || (i == 27 && j == 12) || (i == 27 && j == 42) || (i == 27 && j == 44) || (i == 27 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 27 && j > 0 && j < 11) || (i == 27 && j > 11 && j < 25) || (i == 27 && j > 29 && j < 43) || (i == 27 && j > 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 27 && j > 0 && j < 10) || (i == 27 && j > 11 && j < 42) || (i == 27 && j > 43 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 27 && j > 1 && j < 11) || (i == 27 && j > 12 && j < 43) || (i == 27 && j > 44)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Vig�sima oitava a trig�sima segunda linha
            if (i > 27 && i < 33 && j == 11) || (i > 27 && i < 33 && j == 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 27 && i < 33 && j == 1) || (i > 27 && i < 33 && j == 10) || (i > 27 && i < 33 && j == 12) || (i > 27 && i < 33 && j == 42) || (i > 27 && i < 33 && j == 44) || (i > 27 && i < 33 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i > 27 && i < 33 && j > 0 && j < 11) || (i > 27 && i < 33 && j > 11 && j < 43) || (i > 27 && i < 33 && j > 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i > 27 && i < 33 && j > 0 && j < 10) || (i > 27 && i < 33 && j > 11 && j < 42) || (i > 27 && i < 33 && j > 43 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i > 27 && i < 33 && j > 1 && j < 11) || (i > 27 && i < 33 && j > 12 && j < 43) || (i > 27 && i < 33 && j > 44)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
            
            % Trig�sima terceira linha
            if i == 33 && j > 10 && j < 44
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 33 && j == 1) || (i == 33 && j == 10) || (i == 33 && j == 44) || (i == 33 && j == 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 0.1; % Probabilidade de se manter na mesma c�lula
            end
            if (i == 33 && j > 0 && j < 11) || (i == 33 && j > 43)
                Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para a c�lula ao sul
            end
            if (i == 33 && j > 0 && j < 10) || (i == 33 && j > 43 && j < 48)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para a c�lula a leste
            end
            if (i == 33 && j > 1 && j < 11) || (i == 33 && j > 44)
                Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para a c�lula a oeste
            end
        end
    end
    
%     Ps = zeros(NumCells,NumCells);
%     for i=1:MaxCellY+1
%         for j=1:MaxCellX+1
%             if ~isempty(find(ocu == (i-1)*(MaxCellX+1)+j))
%                 Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = 1; % Probabilidade de se manter na mesma c�lula se esta � uma c�lula ocupada
%             else
%                 if i == 1 % Primeira linha
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.8; % Probabilidade de se manter na mesma c�lula
%                 else % Outras linhas
%                     Ps((i-1)*(MaxCellX+1)+j,(i-2)*(MaxCellX+1)+j) = 0.8; % Probabilidade de ir para o sul
%                 end
%                 
%                 if j == 1 % Primeira coluna
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma c�lula
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para leste
%                 elseif j == MaxCellX+1 % �ltima coluna
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) = Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j) + 0.1; % Probabilidade de se manter na mesma c�lula
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para oeste
%                 else % Outras colunas
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j+1) = 0.1; % Probabilidade de ir para leste
%                     Ps((i-1)*(MaxCellX+1)+j,(i-1)*(MaxCellX+1)+j-1) = 0.1; % Probabilidade de ir para oeste
%                 end
%             end
%         end
%     end
    
end

