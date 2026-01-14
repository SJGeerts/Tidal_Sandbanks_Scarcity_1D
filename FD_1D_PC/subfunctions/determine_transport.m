
vecu_2 = u_xt.^2 + v_xt.^2;

% total velocity u_t^2, incuding waves, as determined by avg contribution to the magnitude squared.
u_e_2_xt = vecu_2 + 1/2 * (u_w./h_on_u).^2;

Q_xt = (gamma.* u_e_2_xt - u_c_2).*(sqrt(gamma.*u_e_2_xt) - sqrt(1/2)*u_c) .* (u_e_2_xt > u_c_2);

% using shear stress direction
q_cap_xt = Q_xt .* u_xt./sqrt(u_e_2_xt);% only u as we assume that the impact of waves on direction is cancelled out here

q_cap = mean(q_cap_xt,2);   % "regular" flow and wave-induced transport
Q = mean(Q_xt,2);       % magnitude of slope-induced transport




