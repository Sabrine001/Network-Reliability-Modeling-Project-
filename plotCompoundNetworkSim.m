% plotCompoundNetworkSim - Main script to run and plot compound network simulations

% Clear workspace and figures
clear all;
close all;
clc;

% Define simulation parameters
K_values = [1, 5, 15, 50, 100];
num_iterations = 1000;

% Run simulations
fprintf('Starting compound network simulation...\n');
[all_results, p_values] = runCompoundNetworkSim(K_values, num_iterations);
fprintf('Simulations complete. Generating plots...\n');

% Create individual plots
markers = {'o', 's', 'd', '^', 'v'};
colors = lines(length(K_values));

for k_idx = 1:length(K_values)
    % Create new figure
    figure;
    
    % Plot results
    semilogy(p_values, all_results(k_idx, :), 'o', ...
        'Color', colors(k_idx,:), ...
        'MarkerFaceColor', 'none');
    
    % Format plot
    grid on;
    xlabel('Probability of Failure (p)');
    ylabel('Average Number of Transmissions');
    title(sprintf('Compound Network Simulation: K = %d Packets', K_values(k_idx)));
    ylim([1 max(all_results(k_idx,:))*1.1]);
    
    % Enhance appearance
    ax = gca;
    ax.FontSize = 12;
    ax.LineWidth = 1.5;
    ax.GridLineStyle = ':';
    
    % Save figure
    savefig(sprintf('compound_network_K%d.fig', K_values(k_idx)));
end

% Create combined plot
figure;
hold on;

for k_idx = 1:length(K_values)
    semilogy(p_values, all_results(k_idx, :), markers{k_idx}, ...
        'Color', colors(k_idx,:), ...
        'MarkerFaceColor', 'none', ...
        'DisplayName', sprintf('K = %d', K_values(k_idx)));
end

% Format combined plot
grid on;
xlabel('Probability of Failure (p)');
ylabel('Average Number of Transmissions');
title('Compound Network Simulation: Combined Results');
legend('Location', 'northwest');

% Enhance appearance
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.5;
ax.GridLineStyle = ':';

% Save combined figure
savefig('compound_network_combined.fig');

% Display completion message
fprintf('All plots have been generated and saved.\n');s