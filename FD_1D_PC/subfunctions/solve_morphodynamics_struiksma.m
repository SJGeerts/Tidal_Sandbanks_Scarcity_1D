h_prev = h; % h is constantly overwritten, so store previous value
determine_transport

% apply struiksma
check_scarcity_violation
mu = (beta_sand(idx_L) + beta_sand)/2;

dh_dx = D_LC * h;
q_b_x = mu .* (q_cap + lambda * Q .* dh_dx); % also for storage

dh_dtau = D_CR * q_b_x;
h = h + dtau * dh_dtau;
