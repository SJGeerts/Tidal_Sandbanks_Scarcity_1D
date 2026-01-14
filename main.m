clear all
close all
format compact

%% only run the line below the first time you open matlab
% set_figure

%% specify input data
addpath('FD_1D_PC/set_functions')

saveDATA = true;

models_name = 'models';
input_filename = ['Input/input_', models_name];
output_filename = ['Output/ModelData/', models_name,'.mat'];

waves_filename = 'Input/input_waveClimates';

read_input_data;                % for all models

% specify models to run:
models_to_run = 1; % just runs the test case
% models_to_run = 2:N_models; % this runs all regular models


%% plotting and output settings
plot_tide = true;
plot_realtime = true;

draw_iter = 5;
backup_iter = 50;

print_diagnostics = false;

%% add paths
addpath('FD_1D_PC')
addpath('FD_1D_PC\subfunctions')
addpath('FD_1D_PC\plotfunctions')

%% run over all models
run_all_models

%%
if saveDATA
        save(output_filename, 'model','input_table', '-v7.3')
end
