% have to extract these values newly every time, has been overwritten in
% previous loop
u_prev_step = u_xt(:,t_prev(t));    
v_prev_step = v_xt(:,t_prev(t));
uv_prev = [u_prev_step; v_prev_step];
zeta_prev = zeta_xt(:,t_prev(t));

% time point ^{n+1-N_t}
u_prev_cycle = u_xt(:,t);
uv_prev_cycle = [u_xt(:,t); v_xt(:,t)];

variableMatrices
uv_star = A_uvstar\b_uvstar;
