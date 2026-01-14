% initialisation of unknowns for all waves
U_w = zeros(N_x,N_waves);   % orbital velocity
phi_w = zeros(N_x,N_waves); % angle w.r.t crest
H_w = zeros(N_x,N_waves);   % significant wave height

% Loop over wave components
for idx_wave = 1:N_waves

    % Initialise arrays for this wave component
    k = zeros(N_x,1);
    c = zeros(N_x,1);
    cg = zeros(N_x,1);

    % Loop over x, from left to right
    for idx_x = 1:N_x

        % Dispersion (Newton-Raphson)
        kh = omega_waves(idx_wave)^2 * depth(idx_x) / g; % initial guess
        for n = 1:10    % 10 is more than enough (could do with 5)
            objective = omega_waves(idx_wave)^2 - g * kh / depth(idx_x) * tanh(kh);
            gradobjective = -g / depth(idx_x) * (tanh(kh) + kh * sech(kh)^2);
            kh = kh - objective / gradobjective;
        end
        k(idx_x) = kh / depth(idx_x);   % store wave number 
    end
    c = omega_waves(idx_wave)./k;       % wave celerity
    cg = 1/2 * c .* (1 + (2 * k .* depth)./sinh(2 * k.*depth)); % group speed

    % Refraction + Shoaling
    phi_w(:,idx_wave) = asin((c .* sin(phi_0(idx_wave)))./c_0(idx_wave));
    H_w(:,idx_wave) = H_0(idx_wave) .* sqrt((c_g0(idx_wave) * cos(phi_0(idx_wave))) ./ (cg .* cos(phi_w(:,idx_wave))));
    U_w(:,idx_wave) = (pi * H_w(:,idx_wave)) ./ (T_w(idx_wave) .* sinh(k .* depth) );
end

% above all in physical space -> non-dimensionalise
U_w = U_w / U_star;