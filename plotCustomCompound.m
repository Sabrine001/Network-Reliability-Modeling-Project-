% Main script to generate network simulation plots with different probabilities
clear all;
close all;
clc;

% Set parameters
K_values = [1, 5, 10];
varying_prob = logspace(-2, 0, 50); % Range from 1% to 99%

% Plot configurations [p1, p2, p3]
% NaN indicates which probability will vary
configs = [
    0.1, 0.6, NaN;  % Figure 1: p3 varies
    0.6, 0.1, NaN;  % Figure 2: p3 varies
    0.1, NaN, 0.6;  % Figure 3: p2 varies
    0.6, NaN, 0.1;  % Figure 4: p2 varies
    NaN, 0.1, 0.6;  % Figure 5: p1 varies
    NaN, 0.6, 0.1   % Figure 6: p1 varies
];

% Generate all six figures
for fig_num = 1:6
    figure('Position', [100, 100, 800, 600]);
    hold on;
    grid on;
    
    p1 = configs(fig_num, 1);
    p2 = configs(fig_num, 2);
    p3 = configs(fig_num, 3);
    
    % For each K value
    for k_idx = 1:length(K_values)
        K = K_values(k_idx);
        sim_results = zeros(size(varying_prob));
        theo_results = zeros(size(varying_prob));
        
        % Run simulation for each probability value
        for i = 1:length(varying_prob)
            if isnan(p1)
                [sim_results(i), theo_results(i)] = runModifiedNetworkSim(varying_prob(i), p2, p3, K);
            elseif isnan(p2)
                [sim_results(i), theo_results(i)] = runModifiedNetworkSim(p1, varying_prob(i), p3, K);
            else
                [sim_results(i), theo_results(i)] = runModifiedNetworkSim(p1, p2, varying_prob(i), K);
            end
        end
        
        % Plot results
        plot(varying_prob, sim_results, '--o', 'DisplayName', sprintf('Simulation K=%d', K));
        plot(varying_prob, theo_results, '-', 'DisplayName', sprintf('Theoretical K=%d', K));
    end
    
    % Set axis properties
    set(gca, 'XScale', 'log', 'YScale', 'log');
    xlabel('Varying Probability');
    ylabel('Success Probability');
    
    % Create appropriate title based on which probability is varying
    if isnan(p1)
        title(sprintf('Figure %d: p1 varying (%.0f%% - %.0f%%), p2=%.0f%%, p3=%.0f%%', ...
            fig_num, min(varying_prob)*100, max(varying_prob)*100, p2*100, p3*100));
    elseif isnan(p2)
        title(sprintf('Figure %d: p1=%.0f%%, p2 varying (%.0f%% - %.0f%%), p3=%.0f%%', ...
            fig_num, p1*100, min(varying_prob)*100, max(varying_prob)*100, p3*100));
    else
        title(sprintf('Figure %d: p1=%.0f%%, p2=%.0f%%, p3 varying (%.0f%% - %.0f%%)', ...
            fig_num, p1*100, p2*100, min(varying_prob)*100, max(varying_prob)*100));
    end
    
    legend('Location', 'best');
    grid on;
    
    % Save figures in both .fig and .png formats
    savefig(sprintf('probability_figure_%d.fig', fig_num));
    print(sprintf('probability_figure_%d', fig_num), '-dpng', '-r300');
end