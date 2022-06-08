function target_points = generate_circle(Position,radius)
    
    target_points.x = Position(1)-radius:0.01:Position(1)+radius;
    target_points.y = -sqrt(radius^2-(target_points.x-Position(1)).^2)+Position(2);
    target_points.y = [target_points.y sqrt(radius^2-(fliplr(target_points.x)-Position(1)).^2)+Position(2)];
    target_points.x = [target_points.x fliplr(target_points.x)];
    for i=1:length(target_points.x)
        if i == length(target_points.x)
            target_points.th(i) = target_points.th(i-1);
        else
%             target_points.th(i) = atan2(target_points.y(i+1)-target_points.y(i),target_points.x(i+1)-target_points.x(i));
            target_points.th(i) = atan2(real(target_points.y(i+1)-target_points.y(i)),real(target_points.x(i+1)-target_points.x(i)));
        end
    end
    
end

