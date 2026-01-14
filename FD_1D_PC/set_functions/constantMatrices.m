O = sparse(N_x,N_x);
coriolis = spdiags(f*ones(N_x,1), 0, N_x,N_x); % constant matrix
Coriolis_2Nx =  [O, -coriolis;
        coriolis, O];

M = spdiags(1/dt*ones(2*N_x,1), 0, 2*N_x,2*N_x); % constant mass matrix

% Derivative matrices
D_LC = sparse([1:N_x],[1:N_x],	1./(dx), N_x, N_x) + ...
         sparse([1:N_x],[N_x,1:N_x-1], -1./(dx), N_x, N_x);

D_LR = sparse([1:N_x],[2:N_x,1],	1./(2*dx), N_x, N_x) + ...
         sparse([1:N_x],[N_x,1:N_x-1], -1./(2*dx), N_x, N_x);

D_CR = sparse([1:N_x],[2:N_x,1],1./(dx), N_x, N_x) + ...
             sparse([1:N_x],[1:N_x],-1./(dx), N_x, N_x);

Laplacian = sparse([1:N_x],[2:N_x,1],1./dx^2, N_x, N_x) + ...
    sparse([1:N_x],[1:N_x],-2./dx^2, N_x, N_x) + ...
    sparse([1:N_x],[N_x,1:N_x-1],1./dx^2, N_x, N_x);

Nabla= [D_LC; 
        O];

OnesP = [ones(N_x,1), zeros(N_x,1); zeros(N_x,1), ones(N_x,1)];

% For solving Exner with sediment scarcity:
% to limit mu to epsilon:
A_eps = sparse([O, -speye(N_x), ones(N_x,1)]);
b_eps = sparse(N_x,1);

% upper bound: h, mu, eps
ub_psi = [h_max;
    ones(N_x,1);
    0];

% objective function for psi_sol
f_lin = [zeros(N_x,1);
    -ones(N_x,1);
    -N_x^2];

