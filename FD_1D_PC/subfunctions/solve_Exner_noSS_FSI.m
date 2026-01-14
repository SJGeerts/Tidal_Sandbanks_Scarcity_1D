% matrices from new iter
L_h_m1 = lambda * D_CR * spdiags(Q_m1, 0, N_x,N_x) * D_LC ;

A_h = speye(N_x)/dtau - th_tau*L_h_m1;
 
b_h_noSS = b_h_fixed  + th_qcap * D_CR * q_cap_m1;

h = A_h\b_h_noSS;
