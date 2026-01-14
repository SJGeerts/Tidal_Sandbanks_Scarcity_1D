%% read out table
full_table = readtable(input_filename);
N_models = height(full_table)-1;
default = full_table(1,:);
input_table = full_table(2:end,:);

%% fill in all NaNs with default values
NaNs_in_table = isnan(input_table{:,2:end});

for idx_model = 1:N_models
    input_table(idx_model, [false, NaNs_in_table(idx_model,:)] ) = default(1,[false, NaNs_in_table(idx_model,:)]);
end
