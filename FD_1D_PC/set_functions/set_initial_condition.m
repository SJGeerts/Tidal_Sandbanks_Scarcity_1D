%% INITIAL CONDITION
Rotate = @(theta_var) [sin(theta_var),  -cos(theta_var); cos(theta_var),  sin(theta_var)];

% written as functions of time, is non-dimensionalised already
uv_0_f = @(t) U0_star/U_star * Rotate(theta-theta0)*[1;0] + Rotate(theta)*[cos(t); e2 * sin(t)] + U4_star/U_star * Rotate(theta-theta4)*[cos(2*t-phi4); e4 * sin(2*t-phi4)];

% temporal derivatives (analytic)
duv_dt_0_f = @(t) Rotate(theta)*[-sin(t); e2 * cos(t)] + 2 * U4_star/U_star * Rotate(theta-theta4)*[-sin(2*t-phi4); e4 * cos(2*t-phi4)];

% extract as vectors
uv_0 = uv_0_f(t_vec');
u_0 = uv_0(1,:);
v_0 = uv_0(2,:);

duv_dt_0 = duv_dt_0_f(t_vec');

if use_linFric
    P_x = duv_dt_0(1,:) - f*v_0 + r_sand*u_0;
    P_y = duv_dt_0(2,:) + f*u_0 + r_sand*v_0;
else
    P_x = duv_dt_0(1,:) - f*v_0 + cd_sand * sqrt(u_0.^2 + v_0.^2) .* u_0;
    P_y = duv_dt_0(2,:) + f*u_0 + cd_sand * sqrt(u_0.^2 + v_0.^2) .* v_0;
end

Pxy = [P_x; P_y]; % forcing vector over time


%%


if plot_tide
    fig =  figure('Name',['Model ', model_name, ' - Basic flow']);
    fig.Position = [400,400,800,400];

    uv0_flow = U0_star/U_star * Rotate(theta-theta0)*[1;0];
    uv2_flow = @(t) Rotate(theta)*[cos(t); e2 * sin(t)];
    uv4_flow = @(t) U4_star/U_star * Rotate(theta-theta4)*[cos(2*t-phi4); e4 * sin(2*t-phi4)];
    % extract as vectors
    uv2 = uv2_flow(t_vec');
    uv4 = uv4_flow(t_vec');

    subplot(121) % plot flow
    plot([0,uv0_flow(1)],[0,uv0_flow(2)])
    hold on
    plot(uv2(1,:),uv2(2,:),'LineWidth',1)
    plot(uv4(1,:),uv4(2,:))
    plot(u_0,v_0,'k','LineWidth',1)
    axis equal
    
    % plot direction
    for idx_plot = 1:8
        plot(u_0(idx_plot*3),v_0(idx_plot*3),'ok','MarkerSize',idx_plot/2+3)
    end
    for idx_plot = 1:5
        plot(uv4(1,idx_plot*3),uv4(2,idx_plot*3),'xk','MarkerSize',idx_plot/2+3)
    end
    plot(uv0_flow(1),uv0_flow(2),'*k')
    xlabel('$u_0$')
    ylabel('$v_0$')
    axis([-1,1,-1,1])
    grid on
    legend({'M0','M2','M4','Total signal','North', 'Crest-line', 'Direction'})

    subplot(122) % plot forcing
    plot(P_x,P_y)
    hold on
    axis equal
   
    % plot direction
    for idx_plot = 1:8
        plot(P_x(idx_plot*3),P_y(idx_plot*3),'ok','MarkerSize',idx_plot)
    end
    axis equal
        axis([-1,1,-1,1]*1.2)
    grid on

    xlabel('$P_x$')
    ylabel('$P_y$')
end