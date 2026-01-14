% advection right hand side, using upwind
%Ad_n = spdiags(u_prev_step, 0, N_x,N_x) * D_LR;
Ad_n = construct_upwind(u_prev_step, N_x, dx,N_x_vec);

N_RHS = [Ad_n, O;
    O, Ad_n];

% advection left hand side, using upwind
%Ad_Nt = spdiags(u_prev_cycle, 0, N_x,N_x) * D_LR;
Ad_Nt = construct_upwind(u_prev_cycle,N_x,dx,N_x_vec);

N_LHS = [Ad_Nt, O;
    O, Ad_Nt];


% friction and coriolis terms
if use_linFric
    S_LHS = S_lin; % for both sides linear in u   
    S_RHS = S_lin;
else
    % can probably make below more efficient by directly doing the matrix computation
    abs_uv_prev = sqrt(u_prev_step.^2 + v_prev_step.^2);
    abs_uv_prev_2Nx = [abs_uv_prev; abs_uv_prev];
    
    abs_uv_cycle = sqrt(u_xt(:,t).^2 + v_xt(:,t).^2);
    abs_uv_cycle_2Nx = [abs_uv_cycle; abs_uv_cycle];

    % use |u^(n+1-N_t)| u^(n+1) on the LHS, and |u^n| u^n on the RHS 
    S_LHS = Coriolis_2Nx + spdiags(cd_on_uv .* abs_uv_cycle_2Nx./h_on_u_2Nx, 0, 2*N_x, 2*N_x);
    S_RHS = Coriolis_2Nx + spdiags(cd_on_uv .* abs_uv_prev_2Nx./h_on_u_2Nx, 0, 2*N_x, 2*N_x);
end

% left hand side matrix and right hand side vecotr
A_uvstar = (M + th * (N_LHS + S_LHS));
b_uvstar = (M - (1-th) * (N_RHS + S_RHS))*uv_prev + OnesP*( th*Pxy(:,t) + (1-th)*Pxy(:,t_prev(t)) ) - Nabla * zeta_prev;

