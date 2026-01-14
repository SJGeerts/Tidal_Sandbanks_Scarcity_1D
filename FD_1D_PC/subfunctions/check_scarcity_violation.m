bool_violated = h >= h_max - NEL_tol; % for numerical accuracy
nonerodibility_violated  = sum(bool_violated) > 0;

% mu_Str for the Struiksma method
mu_Str = (h_max - h)/delta_a;
mu_Str(mu_Str > 1) = 1;
mu_Str(mu_Str < 0) = 0;

