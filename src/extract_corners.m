function corners = extract_corners( M, n )
%EXTRACT_CORNERS Extract the n-highest salient values of a matrix and
%returns it coordinates in the original matrix, M

    % sort the elements of the matrix in descendent order
    sorted = sort(M(:),'descend');
    % select the n-highest values
    n_highest = sorted(1:n);
    corners = struct;

    for i=1:n
        % calculate the index of the n-highest values
        [corners(i).p_y, corners(i).p_x]  = find(M==n_highest(i));
    end
end

