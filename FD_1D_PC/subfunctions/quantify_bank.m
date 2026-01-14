bedlevel = -h*H_star;

%% crest and trough information
peaks = islocalmax(bedlevel);
Npeaks = sum(peaks);
[crestheight, idx_crest] = max(bedlevel);

x_crest(idx_tau) = x_plot(idx_crest);
z_crest(idx_tau) = crestheight;
z_trough(idx_tau) = min(bedlevel);
H_bank(idx_tau) = z_crest(idx_tau)  - z_trough(idx_tau);

sumh(idx_tau) = sum(h);

%% find width of the bank
bool_W = h < 1; 
W_bank(idx_tau) = sum(bool_W) * dx * L_star;

bool_l1_l2 = h < (h_max*0.9999);
l1_l2(idx_tau) = sum(bool_l1_l2) * dx * L_star;

%% store for plotting
