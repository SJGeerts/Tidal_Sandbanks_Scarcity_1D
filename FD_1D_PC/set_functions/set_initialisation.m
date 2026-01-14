%% model matrices
% INITIALISATION OF MATRICES
u_xt = zeros(N_x,N_t);
v_xt = zeros(N_x,N_t);
zeta_xt = zeros(N_x,N_t);

q_u_cap_xt = zeros(N_x,N_t);
q_s_xt = zeros(N_x,N_t);

mu = ones(N_x,1);

%% initialise empty matrices
for idx_x = 1:N_x
    u_xt(idx_x,:) = u_0;
    v_xt(idx_x,:) = v_0;
end


%% construct always constant matrices
constantMatrices

%% model initialisation settings
tau = 0; % time
idx_tau = 0;

sum_h_init = sum(h_init);
h = h_init;


%% initialise storage matrices
N_loops = ceil(tau_end/dtau) + 1;

hrms2_prev = sum((h - 1).^2)*dx;
Gamma_prev = 0;
cmig_prev = 0;

%% for plotting
x_plot = x_vec_u * L_star/1e3;
x_plot_h =  (x_vec_h + dx/2) * L_star/1e3;

%% fourier analysis of initial bathymetry
fft_spectrum = fft(h-mean(h));

k_shift = -N_x/2:N_x/2-1; % all modes analysed by fft

H_k = fftshift(fft_spectrum); % amplitudes corresponding to k_shift

H_k_prev = H_k;

mig_rate_residual = [];
cmig = [];
cmig_star = [];


%% for plotting
x_crest = [];
Gamma_store = [];
H_bank = [];


%% numerical settings stowed away
NEL_tol = eps * (N_x/2); % half of points can have maybe gone wrong in interior point method.
