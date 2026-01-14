figure(fignr)

subplot(3,2,1)
hold off
plot(x_plot_h,bedlevel,'k', 'LineWidth', 1.2)
hold on;
plot([0,x_plot(end)],[0,0],'-k',x_plot_h,h_max*-H_star,'-k')
ylim([-H_star-D_sand_star - 3,2])
xlabel('x (km)')
ylabel('bed level (m)')
xlim([0,L_dom/1e3])

tau_str = sprintf('%0.3f',tau);
title(['Loop ', num2str(idx_tau), ', $\tau =$ ', tau_str,  ', t = ',num2str(round(tau*TmorY)),  ' y '])

subplot(3,2,3)
q_u = q_cap.*mu;
hold off
plot(x_plot,q_cap ,'LineWidth',1.2 )
hold on
plot(x_plot,q_u,'--' ,'LineWidth',1.2 )
plot(x_plot,D_CR*q_u, 'LineWidth',1.2 )
plot([0,x_plot(end)],[0,0],'-k')
ylim([-0.4,0.4])
xlim([0,L_dom/1e3])
ylabel('$<q>, <dq/dx> $')
xlabel('x (km)')

subplot(3,2,2)
depth_k = 2*abs(H_k)/N_x * H_star;
depth_k(k_shift == 0) = depth_k(k_shift == 0)/2;

bar(k_shift,depth_k)
xlim([0,20])
xlabel('Fourier mode')
ylabel('height (m)')


subplot(3,2,5)
yyaxis left
plot(tau_tracker*TmorY,cmig_star,'LineWidth',1.2 )
ylabel('$c_{mig}$ (m/y)')
xlabel('time (y)')

yyaxis right
plot(tau_tracker*TmorY,x_crest,'LineWidth',1.2 )
ylim([0, L_dom/1e3])
ylabel('Crest location (km)')


subplot(3,2,6)
yyaxis left
%plot([0,tau_tracker(end)*TmorY], converged_after_Gamma*[1,1],'k',tau_tracker*TmorY,Gamma_store,'LineWidth',1.2 )
plot(tau_tracker*TmorY,Gamma_store,'LineWidth',1.2 )

ylabel('$\Gamma$ (-)')

yyaxis right
plot(tau_tracker*TmorY,H_bank,'LineWidth',1.2 )
xlabel('time (y)')
ylabel('bank height')
