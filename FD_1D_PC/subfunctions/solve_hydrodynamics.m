check_scarcity_violation  % to construct beta for roughness c_d
morphoMatrices   % Morphodynamically constant matrices (over tidal cycle)

relerr_u = 1;
relerr_v = 1;
k_u = 0;

% continue iterating if tolerance is not reached
while relerr_u > eps_u && relerr_v > eps_u
    k_u = k_u + 1;
    
    if k_u > k_u_max
        hydro_flag = -1; 
        warning('Hydrodynamics does not converge \n stopping simulation \n')
        break
    end
            
    u_xt_before = u_xt;
    v_xt_before = v_xt;

    % timestep over a tidal cycle using Semi-implicit integration method
    for t = 1:N_t
        solve_uvstar    % prediction step   
        solve_zeta      % pressure step
        solve_uv        % correction step
    end

    % determine relative accuracy of new solution compared to previous
    relerr_u = max(max(abs((u_xt - u_xt_before)./u_xt)));
    relerr_v = max(max(abs((v_xt - v_xt_before)./v_xt)));
end

