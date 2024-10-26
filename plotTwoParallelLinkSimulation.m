% Main program for Two Parallel Link Network Simulation
clear all;
close all;
clc;

K_values = [1, 5, 15, 50, 100];
p_values = 0.1:0.01:0.9;
num_iterations = 1000;

colors = {'b', 'r', 'g', 'm', 'k'};

% Initialize storage for results
simulated_results = zeros(length(K_values), length(p_values));

% Run simulation for each K value
for k_idx = 1:length(K_values)
    K = K_values(k_idx);
    
    % Simulate for each probability
    for p_idx = 1:length(p_values)
        p = p_values(p_idx);
        simulated_results(k_idx, p_idx) = runTwoParallelLinkSim(K, p, num_iterations);
    end
    
    % Plot individual K value results
    figure;
    semilogy(p_values, simulated_results(k_idx, :), [colors{k_idx} 'o'], 'MarkerSize', 8);
    grid on;
    xlabel('Channel Error Probability (p)');
    ylabel('Average Number of Transmissions');
    title(['Two Parallel Link Network: K = ' num2str(K) ' Packets']);
    legend('Simulated', 'Location', 'northwest');
    axis([0.1 0.9 1 1e4]);
end

% Create combined plot
figure;
for k_idx = 1:length(K_values)
    semilogy(p_values, simulated_results(k_idx, :), [colors{k_idx} 'o'], 'MarkerSize', 8);
    hold on;
end
grid on;
xlabel('Channel Error Probability (p)');
ylabel('Average Number of Transmissions');
title('Two Parallel Link Network: Combined Results for All K Values');
legend_entries = {};
for k_idx = 1:length(K_values)
    legend_entries{end+1} = ['K=' num2str(K_values(k_idx))];
end
legend(legend_entries, 'Location', 'northwest');
axis([0.1 0.9 1 1e4]);