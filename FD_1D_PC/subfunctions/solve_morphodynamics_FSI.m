h_prev = h; % h is constantly overwritten, so store previous value

%% for now only do with sediment-scarce approach
determine_transport

% store values of timestep m
q_cap_m0 = q_cap;
Q_m0 = Q;

% constants from previous timestep
L_h_m0 = lambda * D_CR * spdiags(Q_m0, 0, N_x,N_x) * D_LC ;
b_h = h_prev/dtau + (1-th_tau) * L_h_m0 * h_prev;
D_qu_m0 = D_CR * spdiags(q_cap_m0, 0, N_x, N_x); % d/dx q_cap matrix for mu in timestep m

% constant part of vector b_h for noSS_FSI
b_h_fixed =  h_prev/dtau + (1-th_tau) * L_h_m0 * h_prev + (1 - th_qcap) * D_CR * q_cap_m0 ;

% initialise values of timestep m+1
q_cap_m1 = q_cap;
Q_m1 = Q;

% convergence criterion
omega_k = 1; % 0.85;
for k_h = 1:k_h_max
    h_prev_iter = h; % store old h
    if ~nonerodibility_violated
        solve_Exner_noSS_FSI % solve new h
        check_scarcity_violation % has to be checked after "prediction"
        mu = ones(N_x,1);

        if nonerodibility_violated
            % determine_transport does not have to be done again
            solve_Exner_withMuEps_FSI
            check_scarcity_violation
         
        end
    else
        % fprintf([num2str(idx_tau),' - ',num2str(k_h),' - using muEps\n'])
        solve_Exner_withMuEps_FSI % solves new h
        check_scarcity_violation

    end

    h_diff = h - h_prev_iter;
    delta_h(total_counter) = max(abs(h_diff));

    % use under-relaxation for new flow estimate
    h = h_prev_iter + omega_k * h_diff;
    
    % simulation can be broken once the new estimate is close to previous
    if delta_h(total_counter) < eps_h && omega_k == 1
        break
    end
   
    % for next cycle using h^k+1 under-relaxation
    solve_hydrodynamics     % solves new hydrodynamics over predicted h in k+1
    if k_h == 1
        % first iteration has the biggest struggle with hydrodynamics
        k_u_taken_first(idx_tau) = k_u;
    end
    determine_transport      % determines transport over new predicted h in k+1

    % new values of flow-induced transport in k+1
    q_cap_m1 = q_cap;
    Q_m1 = Q;

    total_counter = total_counter + 1;
    omega_k = min(1,omega_k*1.07);

end

k_h_taken(idx_tau) = k_h;

if print_diagnostics
    fprintf(['   Loop: ', num2str(idx_tau), '       Morpho required ', num2str(k_h),' steps \n'])
end

dhprev_dx = D_LC * h_prev;
q_b_x = (mu.*q_cap_m0 + lambda * Q_m0 .* dhprev_dx); % also for storage, this is actually for old bathymetry, but using overal mu
Q = Q_m0; % for storage
q_cap = q_cap_m0; % for storage
