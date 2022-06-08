function path = reconstruct_path(came_from,current_node)
    if came_from(current_node) ~= 0
        p = reconstruct_path(came_from,came_from(current_node));
        path = [p current_node];
        return
    else
        path = current_node;
        return
    end
end

