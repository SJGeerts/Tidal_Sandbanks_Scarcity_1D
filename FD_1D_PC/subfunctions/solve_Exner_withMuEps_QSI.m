% Exner equation itself
L_h = lambda * D_CR * spdiags(Q, 0, N_x,N_x) * D_LC ;
A_h = speye(N_x)/dtau - th_tau * L_h;
b_h = h_prev/dtau + (1-th_tau) * L_h * h_prev;

D_qu = D_CR * spdiags(q_cap, 0, N_x, N_x); % d/dx q_cap matrix for mu

% include effect of flow-induced transport capacity on LHS
Aeq_hmu = [A_h,  -D_qu , zeros(N_x,1)];
beq_hmu = b_h;

[psi_sol, ~, exitflag_linprog1, linprog_output] = linprog(f_lin, A_eps, b_eps, Aeq_hmu, beq_hmu, [], ub_psi,options_lin_IP);

iterlinprog(idx_tau) = linprog_output.iterations;

% very rarely, the above method does not work, then we try other solving methods
exitflag_linprog3 = 1;
if exitflag_linprog1 ~= 1
    fprintf(['   Loop: ', num2str(idx_tau), '  ->   interior point method failed \n             ->    Trying with dual-simplex method \n'])

    [psi_sol, ~, exitflag_linprog2] = linprog(f_lin, A_eps, b_eps, Aeq_hmu, beq_hmu, [], ub_psi, options_lin_DS);

    if exitflag_linprog2 ~= 1
        fprintf('              ->    Trying with default method ')
        [psi_sol, ~, exitflag_linprog3] = linprog(f_lin, A_eps, b_eps, Aeq_hmu, beq_hmu, [], ub_psi);
        if exitflag_linprog3 ~= 1
            linprog_flag = -1;      % flag for failed process for main loop
            fprintf('                 -> None of the Linprog solvers has found a suitable solution')
        end
    end
else
    if print_diagnostics
        fprintf(['   Loop: ', num2str(idx_tau), '  ->    Interior-point method succesful \n'])
    end
end

if exitflag_linprog3 == 1 % only store data if one of the methods was correct
    h = psi_sol(1:N_x); % new solution is directly taken from solver, no need to run Exner again
    mu = psi_sol(N_x+1:2*N_x);    % required correction term over x
    epsilon_mu(idx_tau) = psi_sol(end);   % required epsilon for mu
end
