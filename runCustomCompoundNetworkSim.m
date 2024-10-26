function [sim_result, theo_result] = runCustomCompoundNetworkSim(p1, p2, p3, K, num_packets)
% runCustomCompoundNetworkSim Simulates a compound network with given parameters
%
% Inputs:
%   p1 - First probability parameter
%   p2 - Second probability parameter
%   p3 - Third probability parameter
%   K - Number of parallel paths
%   num_packets - Number of packets to simulate
%
% Outputs:
%   sim_result - Simulated packet success probability
%   theo_result - Theoretical packet success probability

% Initialize success counter
successful_packets = 0;

% Run simulation for specified number of packets
for packet = 1:num_packets
    % Initialize path success flag
    path_success = false;
    
    % Check each parallel path
    for path = 1:K
        % Generate random numbers for each probability check
        r1 = rand();
        r2 = rand();
        r3 = rand();
        
        % Check if packet successfully traverses all three segments
        if r1 <= p1 && r2 <= p2 && r3 <= p3
            path_success = true;
            break;  % One successful path is enough
        end
    end
    
    % Count successful packet transmission
    if path_success
        successful_packets = successful_packets + 1;
    end
end

% Calculate simulation result
sim_result = successful_packets / num_packets;

% Calculate theoretical result
% Probability of success for a single path
single_path_prob = p1 * p2 * p3;

% Probability of failure for all K paths
failure_prob = (1 - single_path_prob)^K;

% Theoretical success probability
theo_result = 1 - failure_prob;

end