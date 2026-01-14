%% measure of potential energy
%hrms2(idx_tau+1) = sum((h - 1).^2)*dx ;
%Gamma(idx_tau) = 1/( (hrms2(idx_tau+1)+hrms2(idx_tau))/2 ) * 1/(2*dtau) * (hrms2(idx_tau+1)-hrms2(idx_tau));

hrms2 = sum((h - 1).^2)*dx ;
Gamma = 1/((hrms2 + hrms2_prev) / 2) * 1/(2*dtau) * (hrms2 - hrms2_prev);
dGamma_dtau = (Gamma - Gamma_prev)/dtau;

hrms2_prev = hrms2;
Gamma_prev = Gamma; 


%% Fourier analysis for migration rate
fft_spectrum = fft(h-mean(h));

H_k = fftshift(fft_spectrum); % amplitudes corresponding to k_shift

dHk_dtau  = 1/dtau * (H_k - H_k_prev); % all derivatives
k1 = 1;
dH1_dtau(idx_tau) = dHk_dtau(k_shift == k1); % temporal derivative of largest mode k = 1
cmig(idx_tau) =  dH1_dtau(idx_tau)/(-1i * k1 * 2 * pi/L * (H_k(k_shift == k1) + H_k_prev(k_shift == k1))/2 );
mig_rate_residual(idx_tau,:) = dHk_dtau + cmig(idx_tau) *1i * (k_shift') .*H_k;

cmig_now =  real(cmig(idx_tau)* L_star/TmorY);
dcmig_dtau = (cmig_now - cmig_prev)/dtau;
cmig_prev = cmig_now;

cmig_star(idx_tau) = cmig_now; % in meters per year, store for plotting

Gamma_store(idx_tau) = Gamma;

H_k_prev = H_k;

%{
system_converged = (cycles_needed <= converged_after_cycles && abs(Gamma) < converged_after_Gamma && abs(dGamma_dtau) < converged_after_Gamma);

if cycles_needed == 1
    system_converged = true;
end

% if migration occurs, use acceleration d cmig / dtau as measure
if abs(cmig_now) > cmig_tol
   % fprintf('   Convergence parameters:   ')
   % disp([dcmig_dtau,  abs(Gamma), abs(dGamma_dtau)])
    system_converged = (abs(dcmig_dtau) < converged_acceleration && abs(Gamma) < converged_after_Gamma && abs(dGamma_dtau) < converged_after_Gamma);
end

system_converged = false;
 
%}
