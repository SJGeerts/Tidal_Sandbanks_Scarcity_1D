% variables
% note that u, v and zeta are very large matrices and consider disabling
% storing them
model{idx_modelrun}.h = h_x_store;
model{idx_modelrun}.u = u_xt_store;
model{idx_modelrun}.v = v_xt_store;
model{idx_modelrun}.zeta = zeta_xt_store;

% sediment transport
model{idx_modelrun}.q_bx = q_b_x_store;
model{idx_modelrun}.q_cap = q_cap_x_store;
model{idx_modelrun}.Q = Q_x_store;

model{idx_modelrun}.mu = mu_x_store;


% timing
model{idx_modelrun}.tau = tau_tracker;

model{idx_modelrun}.exitflag = exitflag;
model{idx_modelrun}.cmig = cmig;
model{idx_modelrun}.cmig_star = cmig_star;

model{idx_modelrun}.t_hydro = hydrotime;
model{idx_modelrun}.t_morph = morphtime;
model{idx_modelrun}.t_model = simulationtime;
model{idx_modelrun}.t_tau = tautime;

model{idx_modelrun}.k_u_taken = k_u_taken;

% extra information for FSI method
if th_qcap > 0
    model{idx_modelrun}.k_u_taken_first = k_u_taken_first;
    model{idx_modelrun}.k_h_taken = k_h_taken;
    model{idx_modelrun}.delta_h = delta_h;
end