%% constant Physical parameters
por = 0.4;
omega = 2*pi/(12.42*3600);  % angular frequency M2 tide
Omega = 7.2921e-5;  % rotation earth

g = 9.81;

%%
% physical non-dimensional parameters
L_tide = U_star/omega;
L_star = L_tide;    % normalisation length
L = L_dom / L_star;

cd_sand = cd_sand_star*U_star/(omega*H_star);
cd_NEL = cd_NEL_star*U_star/(omega*H_star);

% linearisation of friction and coriolis
if use_linFric
    r_sand_star = cd_sand_star * 8/(3*pi) * U_star;
    r_sand = r_sand_star/(omega*H_star);
    r_NEL_star = cd_NEL_star * 8/(3*pi) * U_star;
    r_NEL = r_NEL_star/(omega*H_star);
end

f_star = 2*Omega*sind(latitude_d);
f = f_star/omega;

u_c = uc_star/U_star;
u_c_2 = u_c^2;

u_w = uw_star/U_star ;
lambda = lambda_star*H_star/L_star;

D_sand = D_sand_star/H_star;
delta_a = delta_a_star/H_star;

h_max_mean = 1 + D_sand;

alpha = alpha_b_star;
Tmor = (1-por)*H_star*L_star/(alpha*U_star.^3);

TmorY = Tmor/(3600*24*365.24)

