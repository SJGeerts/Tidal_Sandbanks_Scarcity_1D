%% set axis interpreter

% this code only needs to be run once to set the axes interpreter properly

list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for file_select = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(file_select)},'factory','default');
    set(groot, default_name,'latex');
end
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
