L_h = lambda * D_CR *  spdiags(Q, 0, N_x,N_x) * D_LC ; % slope induced transport
A_h = speye(N_x)/dtau - th_tau*L_h;
b_h = h/dtau + D_CR*q_u + (1-th_tau) * L_h * h;

h = A_h\b_h;


