function PI = MDP_policy(r,P,x,V)
    
    % A��o norte
    vn = r(x,1) + V'*P.norte(x,:)';
    % A��o sul
    vs = r(x,2) + V'*P.sul(x,:)';
    % A��o leste
    vl = r(x,3) + V'*P.leste(x,:)';
    % A��o oeste
    vo = r(x,4) + V'*P.oeste(x,:)';
    
    v = [vn vs vl vo];
    % PI = 1 -> a��o norte
    % PI = 2 -> a��o sul
    % PI = 3 -> a��o leste
    % PI = 4 -> a��o oeste
    [value,PI] = max(v);
    
end

