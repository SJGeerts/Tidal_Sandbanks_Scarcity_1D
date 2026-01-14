h_prev = h; % h is constantly overwritten, so store previous value

determine_transport

if ~nonerodibility_violated  % run regular system without non-erodible bed
    q_u = q_cap;
    mu = ones(N_x,1);
    solve_Exner_noSS_QSI

    check_scarcity_violation % has to be checked after "prediction"
    
    if nonerodibility_violated
        % return back to previous h, to run again with non-erodible layer
        h = h_prev;
  
        % determine_transport does not have to be done again
        solve_Exner_withMuEps_QSI
    end

else % run alternative solver for non-erodibility
    solve_Exner_withMuEps_QSI

    % can actually go back to the system where it is not violated in next loop:
    check_scarcity_violation 
    if ~nonerodibility_violated
        fprintf(['   Loop: ', num2str(idx_tau), '      New solution has no exposure of non-erodible layer, going back to regular Exner\n'])
    end
end

dhprev_dx = D_LC * h_prev;
q_b_x = (mu.*q_cap + lambda * Q .* dhprev_dx); % also for storage, this is actually for old bathymetry
