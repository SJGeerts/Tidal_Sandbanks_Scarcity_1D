% space
dx = L/N_x;
x_vec_u = linspace(0,L,N_x + 1)';
x_vec_u = x_vec_u(1:end-1); % on grid cell edges
x_vec_h = x_vec_u + dx/2;   % on grid cell centres

% hydrodynamic time
dt = 2*pi/N_t;
t_vec = linspace(0,2*pi,N_t + 1)';
t_vec = t_vec(1:end-1);

% integer / index vector
N_x_vec = 1:N_x;
t_prev = [N_t, 1:N_t - 1];

idx_R = [2:N_x, 1];
idx_L = [N_x, 1:N_x-1];
idx_C = 1:N_x;


options_lin_IP = optimoptions('linprog','Algorithm','interior-point',...
    'Display','off',...
    'ConstraintTolerance',1e-9,...
    'OptimalityTolerance',1e-9,...
    'MaxIterations',500);%,  'Diagnostics','on');
options_lin_DS = optimoptions('linprog','Algorithm','dual-simplex-highs',...
        'Display','off',...
        'ConstraintTolerance',1e-9,...
        'OptimalityTolerance',1e-9,...
        'MaxIterations',1e7);  %,  'Diagnostics','on');