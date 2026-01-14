h_on_u = (h(idx_L) + h)/2;

% local roughness definition, beta_sand defined in check_scarcity_violation
% necessary for quad friction and local roughness definition in q_b
beta_sand = mu_Str;

% this currently does not do anything as the roughness values are set to
% the same value, but can be used

cd_on_h = beta_sand .* cd_sand + (1-beta_sand).*cd_NEL;
cd_on_u = (cd_on_h(idx_L)+cd_on_h)/2;
gamma = cd_on_u/cd_sand;

if use_linFric
    r_on_h = beta_sand .* r_sand + (1-beta_sand).*r_NEL;
    r_on_u = (r_on_h(idx_L)+r_on_h)/2;

    friction_lin = spdiags(r_on_u./h_on_u, 0, N_x, N_x);
    S_lin = [friction_lin, -coriolis;
             coriolis, friction_lin]; % variable stiffness matrix
else
    % for quadratic friction
    h_on_u_2Nx = [h_on_u; h_on_u];
    cd_on_uv = [cd_on_u; cd_on_u];

end

grad_h = D_LR*h;
%div_hR = D_CR*h;
%div_hL = D_LC*h;

grad_h_D = spdiags(grad_h, 0, N_x,N_x) * D_LR;

h_Laplacian = spdiags(h, 0, N_x,N_x)*Laplacian;

A_zeta = [ones(1,N_x); dx^2*(grad_h_D + h_Laplacian)];




