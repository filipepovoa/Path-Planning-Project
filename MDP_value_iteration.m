function V = MDP_value_iteration(gama,r,P,NumCells)
    
    epsilon = 1e-2;
%     epsilon = 1e-4;
    
    for i=1:NumCells
        V(i) = min(r(i,:)); % Vetor linha
%         V(i) = -100;
    end
    V = V'; % Vetor coluna
    Vanterior = zeros(NumCells,1);
    gain = 1;
    Vatual = gain*ones(NumCells,1);
    while max(abs(Vatual-Vanterior))>epsilon
        Vanterior = Vatual;
        for i=1:NumCells
            % Ação norte
            vn = gama*(r(i,1) + V'*P.norte(i,:)');
%             vn = r(i,1) + gama*V'*P.norte(i,:)';
            % Ação sul
            vs = gama*(r(i,2) + V'*P.sul(i,:)');
%             vs = r(i,2) + gama*V'*P.sul(i,:)';
            % Ação leste
            vl = gama*(r(i,3) + V'*P.leste(i,:)');
%             vl = r(i,3) + gama*V'*P.leste(i,:)';
            % Ação oeste
            vo = gama*(r(i,4) + V'*P.oeste(i,:)');
%             vo = r(i,4) + gama*V'*P.oeste(i,:)';
            
            v = [vn vs vl vo];
            [V(i),index] = max(v);
        end
        Vatual = V;
%         max(abs(Vatual-Vanterior))
    end
    
end

