function target_points = generate_square(Position,len)
    
    x1 = Position(1)-len/2:0.01:Position(1)+len/2;
    y1 = (Position(2)-len/2)*ones(length(x1),1)';
    th1 = 0*ones(length(x1),1)';
    y2 = Position(2)-len/2:0.01:Position(2)+len/2;
    x2 = (Position(1)+len/2)*ones(length(y2),1)';
    th2 = (pi/2)*ones(length(y2),1)';
    x3 = Position(1)+len/2:-0.01:Position(1)-len/2;
    y3 = (Position(2)+len/2)*ones(length(x3),1)';
    th3 = pi*ones(length(x3),1)';
    y4 = Position(2)+len/2:-0.01:Position(2)-len/2;
    x4 = (Position(1)-len/2)*ones(length(y4),1)';
    th4 = (-pi/2)*ones(length(y4),1)';
    target_points.x = [x1 x2 x3 x4];
    target_points.y = [y1 y2 y3 y4];
    target_points.th = [th1 th2 th3 th4];
    
end

