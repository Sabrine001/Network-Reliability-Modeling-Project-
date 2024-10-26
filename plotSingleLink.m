% Main script: Plot calculated and simulated results for a single link network
% Parameters:
KValues = [1, 5, 15, 50, 100]; % Given K values
pValues = linspace(0, 0.99, 100); % 100 equally spaced values between 0 and 1 (avoid p = 1 for division by zero)
N = 1000; % Number of simulations
% Set up the plot for all K values
figure;
hold on;
% Loop over each K value to calculate and plot results
for i = 1:length(KValues)
K = KValues(i); % Current K value
% Initialize result arrays
calculated_Results = zeros(1, length(pValues)); % Preallocate calculated results
simulated_result = zeros(1, length(pValues)); % Preallocate simulated results
for j = 1:length(pValues)
p = pValues(j); % Current probability of failure
% Calculate the expected result using the given formula
if p < 1 % Avoid division by zero case
calculated_Results(j) = K / (1 - p);
else
calculated_Results(j) = Inf; % Handle p = 1 case
end
% Simulate the result using runSingleLinkSim from Appendix A
simulated_result(j) = runSingleLinkSim(K, p, N); % Call the function for simulations
end
% Plot the calculated results for the current K value
semilogy(pValues, calculated_Results, 'LineWidth', 2); % Solid line for calculated results
% Plot the simulated results for the current K value
semilogy(pValues, simulated_result, 'o--', 'LineWidth', 1); % Dotted line with circles for simulation results
end
% Finalize the plot
hold off;
xlabel('Probability of Failure (p)');
ylabel('Average Transmissions');
title('Calculated and Simulated Results for Single Link Network');
legend(arrayfun(@(K) ['K = ', num2str(K)], KValues, 'UniformOutput', false));
grid on;
set(gca, 'YScale', 'log'); % Logarithmic y-scale
%% Function: runSingleLinkSim (from Appendix A)
% Function from Appendix A as provided
function result = runSingleLinkSim(K, p, N)
simResults = zeros(1, N); % Preallocate simulation results array
for i = 1:N
txAttemptCount = 0; % Transmission count
pktSuccessCount = 0; % Successfully transmitted packet count
while pktSuccessCount < K
r = rand; % Generate random number to check for packet success (r > p)
txAttemptCount = txAttemptCount + 1; % Count first attempt
% Retry until packet is successfully transmitted (r > p)
while r < p
r = rand; % Generate new random number for next attempt
txAttemptCount = txAttemptCount + 1; % Count additional attempts
end
pktSuccessCount = pktSuccessCount + 1; % Increment success count after success
end
simResults(i) = txAttemptCount; % Record total number of transmissions
end
result = mean(simResults); % Return average transmissions across simulations
end
