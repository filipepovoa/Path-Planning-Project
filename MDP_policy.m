function PI = MDP_policy(r,P,x,V)
    
    % Ação norte
    vn = r(x,1) + V'*P.norte(x,:)';
    % Ação sul
    vs = r(x,2) + V'*P.sul(x,:)';
    % Ação leste
    vl = r(x,3) + V'*P.leste(x,:)';
    % Ação oeste
    vo = r(x,4) + V'*P.oeste(x,:)';
    
    v = [vn vs vl vo];
    % PI = 1 -> ação norte
    % PI = 2 -> ação sul
    % PI = 3 -> ação leste
    % PI = 4 -> ação oeste
    [value,PI] = max(v);
    
end

