model_name = input_table.Model_name{idx_modelrun};

% switches
use_linFric = input_table.use_linFric(idx_modelrun);
L_dom = input_table.L_dom(idx_modelrun);

% tide
U_star = input_table.U(idx_modelrun);
U0_star = input_table.U0(idx_modelrun);
U4_star = input_table.U4(idx_modelrun);
e2 =  input_table.e2(idx_modelrun);
e4 =  input_table.e4(idx_modelrun);

phi4 = input_table.phi4_d(idx_modelrun) * pi/180;
theta_d = input_table.theta_d(idx_modelrun);
theta = theta_d * pi/180;
theta0 = input_table.theta0_d(idx_modelrun) * pi/180;
theta4 = input_table.theta4_d(idx_modelrun) * pi/180;

% vertical geometry
H_star = input_table.H_star(idx_modelrun);
H_init = input_table.H_init(idx_modelrun);
D_sand_star = input_table.D_sand_star(idx_modelrun);
delta_a_star = input_table.delta_a_star(idx_modelrun);

% roughness
cd_sand_star = input_table.cd_sand_star(idx_modelrun);
cd_NEL_star = input_table.cd_NEL_star(idx_modelrun);

% sediment transport parameters
alpha_b_star = input_table.alpha_b_star(idx_modelrun);
uw_star = input_table.uw_star(idx_modelrun);
uc_star = input_table.uc_star(idx_modelrun);
lambda_star = input_table.lambda_star(idx_modelrun);

latitude_d = input_table.latitude_d(idx_modelrun);

% time and numerics
N_x = input_table.N_x(idx_modelrun);
N_t = input_table.N_t(idx_modelrun);
dtau = input_table.dtau(idx_modelrun);
tau_end = input_table.tau_end(idx_modelrun);

use_Struiksma = input_table.use_Struiksma(idx_modelrun);

th = input_table.th(idx_modelrun);
th_tau = input_table.th_tau(idx_modelrun);
th_qcap = input_table.th_qcap(idx_modelrun);

eps_u =  input_table.eps_u(idx_modelrun);
k_u_max = input_table.k_u_max(idx_modelrun);
eps_h = input_table.eps_h(idx_modelrun);
k_h_max = input_table.k_h_max(idx_modelrun);

