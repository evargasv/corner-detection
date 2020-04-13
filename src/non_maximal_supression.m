function im_supressed = non_maximal_supression( im, N )
%NON_MAXIMAL_SUPRESSION Suppress the values that are not the maximum in a
%neighbourhood of N by N, from an image im

    % apply filter of window size N by N
    im_supressed = nlfilter(im, [N N], @fun);
    
end

function value = fun(x)
%FUN Returns the central value of an matrix in case the value is in the
%center on the matrix, otherwise returns 0

    maximum = max( x(:) );
    if( x(6,6) ~= maximum )
        % the center is not the maximum
        value = 0;
    else
        % the maximum is in the center
        value = x(6,6);
    end
end
