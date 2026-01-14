% these initialisation settings are explicitly stated here, to continue a
% model that was previously interrupted or converged.
cycles_needed = Inf;
hydro_flag = 1;
linprog_flag = 1;
system_converged = false;

exitflag = 0;

total_counter = 1;
t_start_model = tic; 

while tau < tau_end
    t_start_tau = tic;
    idx_tau = idx_tau + 1;

    tau = tau + dtau;
    tau_tracker(idx_tau) = tau;  % in case dtau changes mid simulation

    % hydrodynamics
    t_start_hydro = tic;
    solve_hydrodynamics
        k_u_taken(idx_tau) = k_u;

    hydrotime(idx_tau) = toc(t_start_hydro);   % store calculation time

    if hydro_flag == -1
        warning('       -> stopping simulation \n')
        exitflag = -1;
        break
    end

    % morphodynamics, includes waves in determination of transport
    t_start_morpho = tic;
    solve_morphodynamics_FSI
    morphtime(idx_tau) = toc(t_start_morpho);   % store calculation time

    if linprog_flag == -1
        warning('       -> stopping simulation \n')
        exitflag = -2;
        break
    end

    store_data
    determine_hrms_cmig
if plot_realtime
        quantify_bank % only needed for plotting in real time
        if mod(idx_tau,draw_iter) == 0
            tic
            plot_bedlevel_and_evolution
            drawnow
            plottime(idx_tau) = toc;   % store plotting time
        end
    end

    tautime(idx_tau) = toc(t_start_tau);
end
simulationtime = toc(t_start_model);

if system_converged
    fprintf(['   Simulation finished because hydrodynamics only needed ', num2str(cycles_needed),' cycles \n'])
    exitflag = 1;
end