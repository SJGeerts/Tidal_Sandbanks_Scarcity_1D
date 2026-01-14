% maximum water depth due to non-erodible layer
h_max = h_max_mean + zeros(N_x,1); 

% initial condition of the bathymetry, just a single cosine, amplitude H_init of sand layer thickness  
h_init = ones(N_x,1) + H_init * cos(x_vec_h*2*pi/L);  

% in the slight possibility it is violating the NEL (H_init too large):
% h_init(h_init > h_max * 0.95)  = h_max_mean * 0.95;