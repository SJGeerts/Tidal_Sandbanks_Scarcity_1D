for idx_modelrun = models_to_run

    % nondim
    set_parameters_model
    set_parameters_nonDim

    % save input data to model struct
    model{idx_modelrun} = {};
    model{idx_modelrun}.name = model_name;
    model{idx_modelrun}.input = input_table(idx_modelrun,:);

    % Initialise numerics, initial bathymetry and initialisation of storage matrices
    set_numerics
    set_bathymetry

    set_initial_condition
    set_initialisation

    initialise_storage

    % run, can also be continued from current loop if u,v,zeta,h is not overwritten
    if plot_realtime
        fig = figure('Name',['Model ', model_name, ' - simulation plot']); %,'NumberTitle','off');
        fig.Position = [100,100,600,600];
        fignr = fig.Number;
    end

    fprintf(['\n \n Starting new simulation: ', model_name,'\n'])

    if use_Struiksma
        fprintf('Actually using Struiksma now \n')
        FD_1D_PC_struiksma
    else
        if th_qcap == 0
            FD_1D_PC_QSI
        else
            FD_1D_PC_FSI
        end
    end
    store_model_data
end


