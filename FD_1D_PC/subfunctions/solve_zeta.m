u_star = uv_star(1:N_x); % prediction of u
b_zeta = [0; dx^2* 1/(th*dt)* D_CR * (h_on_u.*u_star)]; % sum of zeta = 0 ; pressure term

delta_zeta = A_zeta\b_zeta; % timestep difference
zeta_xt(:,t)  = zeta_prev + delta_zeta; % zeta in new timestep 