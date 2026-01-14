function N_upwind = construct_upwind(u,N_x,dx,N_x_vec)

if abs(sum(sign(u))) < N_x
    %warning('Sign of u has changed over the array')
    % if this is the case, the upwind direction has to be done for every
    % individual cell

    % first construct basic matrix on the structure of the first element
    if u(1) > 0
        %uses a left structure
        N_upwind = sparse(1:N_x,1:N_x, u, N_x, N_x) + ...
                    sparse(1:N_x,[N_x,1:N_x-1], -u, N_x, N_x);
        
        % shift negative sign to the right to obtain right structure
        neg_sign = sign(u) == -1;
        for row_idx = N_x_vec(neg_sign)
            N_upwind(row_idx,:) = N_upwind(row_idx,[N_x, 1:N_x-1]);
        end

    else
         %uses a right structure
        N_upwind = sparse([1:N_x],[2:N_x,1], u, N_x, N_x) + ...
            sparse([1:N_x],[1:N_x], -u, N_x, N_x);
         % shift positive sign to the right to obtain right structure
         pos_sign = sign(u) == 1;
        for row_idx = N_x_vec(pos_sign)
            N_upwind(row_idx,:) = N_upwind(row_idx,[2:N_x, 1]);
        end
    end 


    
else
    % if the sign remains constant, simply directly fill all rows based on
    % the first element.
    if u(1) > 0
        N_upwind = sparse([1:N_x],[1:N_x], u, N_x, N_x) + ...
                    sparse([1:N_x],[N_x,1:N_x-1], -u, N_x, N_x);
    else
        N_upwind = sparse([1:N_x],[2:N_x,1], u, N_x, N_x) + ...
                    sparse([1:N_x],[1:N_x], -u, N_x, N_x);
    end
end


N_upwind = N_upwind/dx;


end